// Dart imports:
import 'dart:async';

// Project imports:
import 'package:leafy_leasing/shared/base.dart';
import 'package:retry/retry.dart';

export 'appointment_provider.dart';
export 'customer_provider.dart';
export 'notification_provider.dart';
export 'settings_provider.dart';

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
  Future<T> buildFromPolling(
    ID id,
    AutoDisposeFutureProvider<(Repository<T, ID>, Cache<T>)>
        cachedRepositoryProvider, {
    int intervalInMilliseconds = 5000,
    ErrorUiCallback? errorUiCallback,
  }) {
    _initialize(cachedRepositoryProvider);
    Timer.periodic(intervalInMilliseconds.milliseconds, (_) async {
      try {
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
  Future<T> buildFromStream(
    ID id,
    AutoDisposeFutureProvider<(Repository<T, ID>, Cache<T>)>
        cachedRepositoryProvider, {
    ErrorUiCallback? errorUiCallback,
  }) {
    _initialize(cachedRepositoryProvider);
    repository.listenable(id).listen((appointment) {
      state = AsyncValue.data(appointment);
    });
    return repository.get(id);
  }

  /// Optimistically update, meaning that the state is updated before the network
  /// call is made. If the network call fails, the state is reverted to the
  /// previous state.
  @protected
  Future<void> optimisticPut(
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
  Future<T> retryAndLog(Future<T> Function() function,
      {String? loggingKey, bool isPut = false}) async {
    return retry(
      function,
      maxAttempts: kNumberPutRetries,
      onRetry: (e) => logOnNetworkRetry<T>(loggingKey, e, isPut: isPut),
    );
  }

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
}
