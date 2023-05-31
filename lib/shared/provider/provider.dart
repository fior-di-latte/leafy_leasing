// Dart imports:
import 'dart:async';
import 'dart:io';

// Project imports:
import 'package:leafy_leasing/shared/base.dart';
import 'package:retry/retry.dart';

export 'appointment_provider.dart';
export 'customer_provider.dart';
export 'notification_provider.dart';
export 'settings_provider.dart';

enum FetchingStrategy { single, polling, stream }

// fallback: if internet connection is not available, search in cache, if not found, retry to fetch
//           if internet connection is available, fetch, if fails, try cache, if fails retry fetch
// eagerCacheWhileLoading: regardless of internet connection, initialize data from cache first, then fetch
// no: no cache at all is used.
enum CacheReadStrategy { fallback, eager, no }

typedef ErrorUiCallback = void Function(BuildContext context);

mixin AsyncProviderMixin<T, ID> {
  @protected
  late Repository<T, ID> repository;
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
  }

  @protected
  Future<T> _fromPolling({
    required Duration interval,
  }) {
    _pollingTimer = Timer.periodic(interval, (_) async {
      try {
        if (mounted) state = AsyncLoading<T>();
        final newValue = await repository.get(_id);
        if (mounted) state = AsyncValue.data(newValue);
        logger.i('Polling successful: $newValue');
      } catch (e, stackTrace) {
        logger.e('Polling Error: $e');
        state = AsyncValue.error(e, stackTrace);
      }
    });
    return repository.get(_id);
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

    await _initializeFields(id, cachedRepositoryProvider, cacheRead);

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
    return repository.get(_id);
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

  // Future<T> _get(ID id) => switch (_cacheRead) {
  //       (CacheReadStrategy.fallback) => _getWithFallback(id),
  //       (CacheReadStrategy.eager) => _getWithEager(id),
  //       (CacheReadStrategy.no) => _getWithNoCache(id),
  //     };

  Future<T> _get(ID id) =>
      retryAndLog(() => repository.get(id), loggingKey: id.toString());

  Future<T> _getWithFallback(ID id) {
    throw UnimplementedError();
  }

  Future<T> _getWithEager(ID id) {
    throw UnimplementedError();
  }

  Future<T> _getWithNoCache(ID id) {
    throw UnimplementedError();
  }

  // Future<T> rofl([String? id]) => asyncWrapper(
  //       () async {
  //         print('haha');
  //         try {
  //           final incomingValue = await getter(id);
  //           // update cache
  //           await _cache.put(id ?? 'globalKey', incomingValue);
  //           return incomingValue;
  //         } catch (e) {
  //           // check if cache fallback is available
  //           final cachedFallback = await _cache.get(id ?? 'globalKey');
  //           if (cachedFallback != null) {
  //             logger.i(
  //               '😅 Cache Fallback Used! Found $id in cache, returning $cachedFallback',
  //             );
  //             return cachedFallback;
  //           }
  //
  //           // no incoming value && no cache fallback -> rethrow Error
  //           logger.w('No incoming value and no cache fallback for $id');
  //           rethrow;
  //         }
  //       },
  //       loggingKey: id,
  //     );

  Future<T> put(T item, {required ID id}) => retryAndLog(
        () => repository.put(item, id: id),
        loggingKey: item.toString(),
      );

  Future<T> _fromGet() => _get(_id);

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
