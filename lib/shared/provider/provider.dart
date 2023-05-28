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
  late final Repository<T, ID> repository;
  late final Cache<T> cache;

  abstract AsyncValue<T> state;
  AutoDisposeAsyncNotifierProviderRef<T> get ref;
  late final notifications = ref.read(notificationProvider.notifier);

  Future<void> _initialize(
    AutoDisposeFutureProvider<(Repository<T, ID>, Cache<T>)>
        cachedRepositoryProvider,
  ) async {
    final cachedRepository = await ref.watch(cachedRepositoryProvider.future);
    repository = cachedRepository.$1;
    cache = cachedRepository.$2;
  }

  @protected
  Future<T> _fromPolling(
    ID id, {
    required Duration intervalInMilliseconds,
    ErrorUiCallback? errorUiCallback,
  }) {
    Timer.periodic(intervalInMilliseconds, (_) async {
      try {
        state = AsyncLoading<T>();
        final newValue = await repository.get(id);
        state = AsyncValue.data(newValue);
        logger.i('Polling successful: $newValue');
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
    Duration pollingIntervalInMilliseconds = const Duration(milliseconds: 5000),
  }) async {
    await _initialize(cachedRepositoryProvider);
    return switch (strategy) {
      (FetchingStrategy.single) =>
        _fromGet(id, errorUiCallback: errorUiCallback),
      (FetchingStrategy.stream) =>
        _fromStream(id, errorUiCallback: errorUiCallback),
      (FetchingStrategy.polling) => _fromPolling(id,
          errorUiCallback: errorUiCallback,
          intervalInMilliseconds: pollingIntervalInMilliseconds),
    };
  }

  Future<T> _fromStream(
    ID id, {
    ErrorUiCallback? errorUiCallback,
  }) {
    repository.listenable(id).listen((appointment) {
      state = AsyncValue.data(appointment);
    });
    return repository.get(id);
  }

  /// Optimistically update, meaning that the state is updated before the network
  /// call is made. If the network call fails, the state is reverted to the
  @protected
  Future<void> _optimistic(
    T newValue, {
    required ID id,
    bool invalidateFinally = false,
    FutureOr<void> Function()? onFinally,
    ErrorUiCallback? errorUiCallback,
    bool showErrorUiCallback = true,
  }) async {
    final oldValue = state;
    logger.i('Optimistic Update: $newValue');
    state = AsyncValue.data(newValue);
    // loading has no effect on UI once the state has had a value once
    // this is only for consistency
    state = AsyncValue<T>.loading();
    try {
      // throw Exception('Network Error');
      await repository.put(newValue, id: id);
      logger.w('Successful network update $repository.');
    } catch (e) {
      logger.e('NetworkError | Naive optimism: $e');
      if (showErrorUiCallback) {
        notifications.state = _getErrorSnackbarBuilder(errorUiCallback);
      }
      state = oldValue;
    } finally {
      if (invalidateFinally) {
        ref.invalidateSelf();
      }
      onFinally?.call();
    }
  }

  /// previous state.
  @protected
  Future<void> optimistic(
    T newValue, {
    required ID id,
    bool invalidateFinally = false,
    FutureOr<void> Function()? onFinally,
    ErrorUiCallback? errorUiCallback,
    bool showErrorUiCallback = true,
  }) async {
    final oldValue = state;
    logger.i('Optimistic Update: $newValue');
    state = AsyncValue.data(newValue);
    // loading has no effect on UI once the state has had a value once
    // this is only for consistency and loading time logging.
    state = AsyncValue<T>.loading();
    try {
      // throw Exception('Network Error');
      await repository.put(newValue, id: id);
      logger.w('Successful network update $repository.');
    } catch (e) {
      logger.e('NetworkError | Naive optimism: $e');
      if (showErrorUiCallback) {
        notifications.state = _getErrorSnackbarBuilder(errorUiCallback);
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

  void _defaultErrorCallback(BuildContext context) => showTopInfo(
        context,
        textColor: context.cs.error,
        leading: Icon(
          Icons.error_outline_outlined,
          color: context.cs.error,
        ),
        title: context.lc.somethingWentWrong,
      );

  SnackbarBuilder _getErrorSnackbarBuilder(ErrorUiCallback? errorUiCallback) {
    return errorUiCallback == null
        ? SnackbarBuilder(_defaultErrorCallback, type: SnackbarType.error)
        : SnackbarBuilder(errorUiCallback, type: SnackbarType.error);
  }

  Future<T> _fromGet(ID id, {ErrorUiCallback? errorUiCallback}) => get(id);
}
