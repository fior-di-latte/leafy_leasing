// Dart imports:
import 'dart:async';

// Project imports:
import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/repository/abstract_repository.dart';
import 'package:retry/retry.dart';

export 'appointment_provider.dart';
export 'customer_provider.dart';
export 'notification_provider.dart';
export 'settings_provider.dart';

typedef ErrorUiCallback = void Function(BuildContext context);

mixin AsyncProviderMixin<T, ID> {
  @protected
  late final (Repository<T, ID>, Cache<T>) repoCache;
  Repository<T, ID> get repository => repoCache.$1;
  Cache<T> get cache => repoCache.$2;

  abstract AsyncValue<T> state;
  AutoDisposeAsyncNotifierProviderRef<T> get ref;
  late final notifications = ref.read(notificationProvider.notifier);

  @protected
  Future<T> buildFromPolling(
    ID id, {
    int intervalInMilliseconds = 5000,
    ErrorUiCallback? errorUiCallback,
  }) {
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
    ID id, {
    ErrorUiCallback? errorUiCallback,
  }) {
    print('witzig ${repository.runtimeType}}');
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

  Future<T> getter(ID id) => repository.get(id);

  Future<T> putter(T item, {required ID id}) => repository.put(item, id: id);

  Stream<T> listenable() {
    // TODO: implement listenable
    throw UnimplementedError();
  }

  void dispose() {
    // TODO: implement dispose
  }

  @protected
  Future<T> asyncWrapper(Future<T> Function() function,
      {String? loggingKey, bool isPut = false}) async {
    return retry(
      function,
      maxAttempts: kNumberPutRetries,
      onRetry: (e) => logOnNetworkRetry<T>(loggingKey, e, isPut: isPut),
    );
  }

  Future<T> get(ID id) => asyncWrapper(() {
        print('wtf');
        return getter(id);
      }, loggingKey: id.toString());

  Future<void> put(T item, {required ID id}) async {
    asyncWrapper(() => putter(item, id: id), loggingKey: item.toString());
  }

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
