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

typedef ErrorUiCallback = void Function(BuildContext context);

mixin AsyncProviderMixin<T, ID> {
  @protected
  late Repository<T, ID> repository;
  late Cache<T> cache;
  // this should be identical to the parameter 'id' from the build method,
  // if it exists
  late ID _id;
  late final Timer
      _pollingTimer; // this can be final as _fromPolling is called only once after the cachedRepository is initialized;

  abstract AsyncValue<T> state;
  AutoDisposeAsyncNotifierProviderRef<T> get ref;

  Future<void> _initialize(
    ID id,
    AutoDisposeFutureProvider<(Repository<T, ID>, Cache<T>)>
        cachedRepositoryProvider,
  ) async {
    _id = id;
    final cachedRepository = await ref.watch(cachedRepositoryProvider.future);
    repository = cachedRepository.$1;
    cache = cachedRepository.$2;
  }

  @protected
  Future<T> _fromPolling(
    ID id, {
    required Duration interval,
    ErrorUiCallback? errorUiCallback,
  }) {
    _pollingTimer = Timer.periodic(interval, (_) async {
      try {
        if (mounted) {
          state = AsyncLoading<T>();
          final newValue = await repository.get(id);
          state = AsyncValue.data(newValue);
          logger.i('Polling successful: $newValue');
        }
      } catch (e, stackTrace) {
        logger.e('Polling Error: $e');
        state = AsyncValue.error(e, stackTrace);
      }
    });
    return repository.get(id);
  }

  @protected
  Future<T> buildFromRepository(
    AutoDisposeFutureProvider<(Repository<T, ID>, Cache<T>)>
        cachedRepositoryProvider, {
    required ID id,
    required FetchingStrategy strategy,
    ErrorUiCallback? errorUiCallback,
    Duration pollingInterval = const Duration(milliseconds: 5000),
  }) async {
    _mount();
    _onDispose();

    await _initialize(id, cachedRepositoryProvider);
    return switch (strategy) {
      (FetchingStrategy.single) =>
        _fromGet(id, errorUiCallback: errorUiCallback),
      (FetchingStrategy.stream) =>
        _fromStream(id, errorUiCallback: errorUiCallback),
      (FetchingStrategy.polling) => _fromPolling(id,
          errorUiCallback: errorUiCallback, interval: pollingInterval),
    };
  }

  Future<T> _fromStream(
    ID id, {
    ErrorUiCallback? errorUiCallback,
  }) {
    repository.listenable(id).listen((incomingData) {
      try {
        logger.w('hello ${incomingData.runtimeType}');
        if (mounted) {
          logger.w('ridic${incomingData.runtimeType}');
          state = AsyncValue.data(incomingData);
        }
      } on StateError catch (_) {
        logger.e('Riverpod "async gap" error.');
        // Some internal Riverpod exception that is called
        // when a Completer is called when the future is already finished.
      }
    });
    return repository.get(id);
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
    logger.i('Optimistic Update: $newValue');
    state = AsyncValue.data(newValue);
    // TODO investigate why this yields a "async gap" error
    state = AsyncValue<T>.loading();
    // loading has no effect on UI once the state has had a value once
    // this is only for consistency and loading time logging.

    try {
      await repository.put(newValue, id: foreignId ?? _id);
      // this state may be false if some action
      // on the server happens, concurrently
      state = AsyncValue.data(newValue);
      logger.w('Successful network update $repository.');
    } catch (e) {
      logger.e('NetworkError | Naive optimism: $e');
      if (showErrorUiCallback) {
        ref.notification = errorSnackbar ?? SnackbarBuilder.error();
      }
      state = oldValue;
    } finally {
      if (invalidateFinally) {
        ref.invalidateSelf();
      }
      onFinally?.call();
    }
  }

  Future<T> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Stream<T> listenable() {
    // TODO: implement listenable
    throw UnimplementedError();
  }

  void dispose() {
    // TODO: implement dispose
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
  Future<T> get(ID id) =>
      retryAndLog(() => repository.get(id), loggingKey: id.toString());

  Future<T> put(T item, {required ID id}) => retryAndLog(
        () => repository.put(item, id: id),
        loggingKey: item.toString(),
      );

  Future<T> _fromGet(ID id, {ErrorUiCallback? errorUiCallback}) => get(id);

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
