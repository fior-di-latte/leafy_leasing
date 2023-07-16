// Dart imports:
import 'dart:async';
import 'dart:io';

import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/provider/internet_connection_provider.dart';
// Project imports:
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:retry/retry.dart';

export 'appointment_provider.dart';
export 'customer_provider.dart';
export 'notification_provider.dart';
export 'settings_provider.dart';

// fallback: if internet connection is not available, search in cache, if not found, retry to fetch
//           if internet connection is available, fetch, if fails, try cache, if fails retry fetch
// eagerCacheWhileLoading: regardless of internet connection, initialize data from cache first, then fetch
// no: no cache at all is used.
enum CacheReadStrategy { fallback, eager, no }

typedef ErrorUiCallback = void Function(BuildContext context);

mixin AsyncCachedProviderMixin<T, ID> {
  @protected
  late Repository<T, ID> repository;
  bool _initialized = false;
  late Cache<T> _cache;
  late CacheReadStrategy _cacheRead;
  // this should be identical to the parameter 'id' from the build method,
  // if it exists
  late ID _id;
  // this can be final as _fromPolling is called only once after
  // the cachedRepository is initialized (that triggers a rebuild
  late final Timer _pollingTimer;

  abstract AsyncValue<T> state;
  AutoDisposeAsyncNotifierProviderRef<T> get ref;

  Future<void> _initializeFields(
    ID id,
    AutoDisposeFutureProvider<(Repository<T, ID>, Cache<T>)>
        cachedRepositoryProvider,
    CacheReadStrategy cacheRead,
  ) async {
    _id = id;
    _cacheRead = cacheRead;
    final cachedRepository = await ref.watch(cachedRepositoryProvider.future);
    repository = cachedRepository.$1;
    _cache = cachedRepository.$2;
    _initialized = true;
  }

  @protected
  Future<T> _fromPolling({
    required Duration interval,
  }) {
    _pollingTimer = Timer.periodic(interval, (_) async {
      try {
        if (mounted) state = AsyncLoading<T>();
        final newValue = await _get();
        if (mounted) state = AsyncValue.data(newValue);
        logger.i('Polling successful: $newValue');
      } catch (e, stackTrace) {
        logger.e('Polling Error: $e');
        state = AsyncValue.error(e, stackTrace);
      }
    });
    return _get();
  }

  @protected
  Future<T> buildFromRepository(
    AutoDisposeFutureProvider<(Repository<T, ID>, Cache<T>)>
        cachedRepositoryProvider, {
    required ID id,
    required FetchingStrategy strategy,
    Duration pollingInterval = const Duration(milliseconds: 5000),
    CacheReadStrategy cacheRead = CacheReadStrategy.fallback,
  }) async {
    _mount();
    _onDispose();

    if (!_initialized) {
      await _initializeFields(id, cachedRepositoryProvider, cacheRead);
    }

    return switch (strategy) {
      (FetchingStrategy.single) => _fromGet(),
      (FetchingStrategy.stream) => _fromStream(),
      (FetchingStrategy.polling) => _fromPolling(interval: pollingInterval),
    };
  }

  Future<T> _fromStream() {
    repository.listenable(_id).listen((incomingData) {
      if (mounted) state = AsyncValue.data(incomingData);
    });
    return _get();
  }

  @protected
  Future<void> optimistic(
    T newValue, {
    // only use foreign Id if you want to update a foreign object from the family
    ID? foreignId,
    bool invalidateFinally = false,
    FutureOr<void> Function()? onFinally,
    SnackbarBuilder? errorSnackbar,
    bool showErrorUiCallback = true,
  }) async {
    final oldValue = state;
    final usedId = foreignId ?? _id;
    logger.i('Optimistic Update: $newValue');
    if (mounted) {
      state = AsyncValue.data(newValue);
      // loading has no effect on UI once the state has had a value once
      // this is only for consistency and loading time logging.
      state = AsyncValue<T>.loading();
    }
    try {
      await repository.put(newValue, id: usedId);
      // this state may be false if some action
      // on the server happens, concurrently
      if (mounted) state = AsyncValue.data(newValue);

      logger.w('Successful network update $repository.');
    } catch (e, stackTrace) {
      logger.e('NetworkError | Naive optimism for $T $usedId:'
          ' $e \n\t Stacktrace $stackTrace');
      if (showErrorUiCallback) {
        ref.notification = errorSnackbar ?? SnackbarBuilder.error();
      }
      if (mounted) state = oldValue;
    } finally {
      if (invalidateFinally) {
        ref.invalidateSelf();
      }
      onFinally?.call();
    }
  }

  @protected
  Future<T> retryAndLog(
    Future<T> Function() function, {
    String? loggingKey,
    bool isPut = false,
  }) =>
      retry(
        function,
        maxAttempts: kNumberPutRetries,
        retryIf: (e) => e is SocketException || e is TimeoutException,
        onRetry: (e) => logOnNetworkRetry<T>(loggingKey, e, isPut: isPut),
      );

// fallback: if internet connection is not available, search in cache, if not found, retry to fetch
//           if internet connection is available, fetch, if fails, try cache, if fails retry fetch
// eagerCacheWhileLoading: regardless of internet connection, initialize data from cache first, then fetch
// no: no cache at all is used.
  Future<T> _get() => switch (_cacheRead) {
        (CacheReadStrategy.fallback) => _getWithFallback(),
        (CacheReadStrategy.eager) => _getWithEager(),
        (CacheReadStrategy.no) => _getFromRepository(),
      };

  Future<T> _getWithFallback() async {
    final hasInternet = ref
            .read(internetConnectionProvider)
            .whenData((value) => value == InternetConnectionStatus.connected)
            .value ??
        true;

    if (!hasInternet) {
      final maybeCacheValue = await _cache.get(_id.toString());
      if (maybeCacheValue == null) {
        throw NoCacheFallbackException(T, _id.toString());
      }
      logger.i(
        '😅 Cache Fallback Used! Found $_id in cache, returning $maybeCacheValue',
      );
      return maybeCacheValue;
    }
    // has internet
    return _getFromRepository();
  }

  Future<T> _getWithEager() async {
    final maybeCachedValue = await _cache.get(_id.toString());
    if (maybeCachedValue != null && mounted) {
      state = AsyncValue.data(maybeCachedValue);
      state = AsyncLoading<T>();
    }
    // in this short async gap the provider could be disposed
    return _getFromRepository();
  }

  Future<T> _getFromRepository() => retryAndLog(
        () async {
          final incoming = await repository.get(_id);
          await _cache.put(_id.toString(), incoming);
          return incoming;
        },
        loggingKey: _id.toString(),
      );

  Future<T> put(T item, {ID? id}) => retryAndLog(
        () => repository.put(item, id: id ?? _id),
        loggingKey: item.toString(),
      );

  Future<T> _fromGet() => _get();

  // 'Mounted' mixin, as in riverpod issue 1879
  Object? _initial;
  late Object _current;

  // Call this from the `build()` method
  void _mount() {
    _current = Object();
    _initial ??= _current;
    // on dispose, set to a different [Object]
    ref.onDispose(() => _current = Object());
  }

  // Whether the notifier is currently mounted
  // This relies on the fact that an [Object] instance is equal to itself only.
  bool get mounted => _current == _initial;

  void _onDispose() {
    ref.onDispose(() {
      try {
        _pollingTimer.cancel();
        logger.d('Polling timer for $T $_id disposed');
      } catch (e) {
        // no polling used
      }
    });
  }
}

class NoCacheFallbackException implements Exception {
  NoCacheFallbackException(this.type, this.id);
  final Type type;
  final String id;
  @override
  String toString() => 'No Internet (according to provider) and'
      ' no cached value for $type $id found.';
}
