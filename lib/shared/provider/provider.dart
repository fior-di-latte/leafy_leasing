import 'dart:async';

import 'package:leafy_leasing/shared/base.dart';

import 'package:leafy_leasing/shared/repository/abstract_repository.dart';
export 'appointment_provider.dart';
export 'customer_provider.dart';
export 'notification_provider.dart';
export 'settings_provider.dart';

typedef ErrorUiCallback = void Function(BuildContext ctx);

mixin AsyncRepositoryMixin<T> {
  late AsyncRepository<T> repository;
  abstract AsyncValue<T> state;
  AutoDisposeAsyncNotifierProviderRef<T> get ref;
  late final notifications = ref.read(notificationProvider.notifier);

  Future<T> buildFromPolling({int intervalInMilliseconds = 5000}) {
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

  Future<T> buildFromStream() {
    repository.listenable().listen((appointment) {
      state = AsyncValue.data(appointment);
    });
    return repository.get();
  }

  Future<void> optimisticPut(
    T newValue, {
    bool invalidateFinally = false,
    ErrorUiCallback? errorUiCallback,
    bool defaultCallback = true,
  }) async {
    final oldValue = state.value as T;
    logInfo('Optimistic Update: $newValue');
    state = AsyncValue.data(newValue);
    try {
      // throw Exception('Network Error');
      await repository.put(newValue);
      logWarning('Successful network update.');
    } catch (e) {
      logError('NetworkError | Naive optimism: $e');
      if (errorUiCallback != null) {
        notifications.state = errorUiCallback;
      } else if (defaultCallback) {
        notifications.state = _defaultErrorCallback;
      }
      state = AsyncValue.data(oldValue);
    } finally {
      if (invalidateFinally) {
        ref.invalidateSelf();
      }
    }
  }

  void _defaultErrorCallback(BuildContext ctx) => showTopInfo(
        ctx,
        textColor: ctx.cs.error,
        leading: Icon(
          Icons.error_outline_outlined,
          color: ctx.cs.error,
        ),
        title: ctx.lc.somethingWentWrong,
      );
}
