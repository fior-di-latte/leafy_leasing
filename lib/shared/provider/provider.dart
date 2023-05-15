// Dart imports:
import 'dart:async';

// Project imports:
import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/repository/abstract_repository.dart';

export 'appointment_provider.dart';
export 'customer_provider.dart';
export 'notification_provider.dart';
export 'settings_provider.dart';

typedef ErrorUiCallback = void Function(BuildContext context);

mixin AsyncProviderMixin<T> {
  late AsyncRepository<T> repository;
  abstract AsyncValue<T> state;
  AutoDisposeAsyncNotifierProviderRef<T> get ref;
  late final notifications = ref.read(notificationProvider.notifier);

  Future<T> buildFromPolling({
    int intervalInMilliseconds = 5000,
    ErrorUiCallback? errorUiCallback,
  }) {
    Timer.periodic(intervalInMilliseconds.milliseconds, (_) async {
      try {
        final newValue = await repository.get();
        state = AsyncValue.data(newValue);
        logger.i('Polling successful: $newValue');
      } catch (e, stackTrace) {
        logger.e('Polling Error: $e');
        state = AsyncValue.error(e, stackTrace);
      }
    });
    return repository.get();
  }

  Future<T> buildFromStream({
    ErrorUiCallback? errorUiCallback,
  }) {
    repository.listenable().listen((appointment) {
      state = AsyncValue.data(appointment);
    });
    return repository.get();
  }

  /// Optimistically update, meaning that the state is updated before the network
  /// call is made. If the network call fails, the state is reverted to the
  /// previous state.
  Future<void> optimisticPut(
    T newValue, {
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
      await repository.put(newValue);
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
