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

mixin AsyncRepositoryMixin<T> {
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
        logInfo('Polling successful: $newValue');
      } catch (e, stackTrace) {
        logError('Polling Error: $e');
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

  Future<void> optimisticPut(
    T newValue, {
    bool invalidateFinally = false,
    FutureOr<void> Function()? onFinally,
    ErrorUiCallback? errorUiCallback,
    bool showErrorUiCallback = true,
  }) async {
    final oldValue = state;
    logInfo('Optimistic Update: $newValue');
    state = AsyncValue.data(newValue);
    try {
      // throw Exception('Network Error');
      await repository.put(newValue);
      logWarning('Successful network update.');
    } catch (e) {
      logError('NetworkError | Naive optimism: $e');
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
