import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/data_services/hive.dart';

final appointmentProvider = StateNotifierProvider.autoDispose
    .family<AppointmentNotifier, AsyncValue<Appointment>, String>(
  name: 'AppointmentProvider',
  (ref, id) => AppointmentNotifier(ref, id: id),
);

abstract class AppointmentNotifier
    implements StateNotifier<AsyncValue<Appointment>> {
  factory AppointmentNotifier(AutoDisposeRef ref, {required String id}) =>
      dotenv.get('USE_HIVE_MOCK_BACKEND') == 'true'
          ? AppointmentHiveNotifier(ref, id: id)
          : AppointmentHiveNotifier(ref, id: id);

  Future<void> cancelAppointment({
    required AppointmentStatus newStatus,
    required String? comment,
  });

  Future<void> closeAppointment({
    required AppointmentStatus newStatus,
    required String? comment,
  });
}

class AppointmentHiveNotifier extends HiveAsyncStreamNotifier<Appointment>
    implements AppointmentNotifier {
  AppointmentHiveNotifier(super.ref, {required String id})
      : super(boxName: hiveAppointments, key: id);

  @override
  Future<void> cancelAppointment({
    required AppointmentStatus newStatus,
    required String? comment,
  }) async {
    final oldValue = state.value!;
    final newValue = state.value!.copyWith(comment: comment, status: newStatus);

    try {
      // set state to `loading` before starting the asynchronous work
      state = const AsyncValue.loading();
      // do the async work
      logInfo('Optimistic update: Cancel Appointment: $newValue');
      state = AsyncValue.data(newValue);
      await repository.put(newValue);
    } catch (e) {
      // if the payment failed, set the error state
      // state = const AsyncValue.error('Could not place order');
      state = AsyncValue.data(oldValue);
      ref.read(notificationProvider.notifier).state = (ctx) => showTopInfo(
            ctx,
            textColor: ctx.cs.error,
            leading: Icon(
              Icons.account_balance_outlined,
              color: ctx.cs.error,
            ),
            title: 'Das ist ein Error',
          );
    } finally {
      // set state to `data(null)` at the end (both for success and failure)
      ref.invalidateSelf();
    }

    // state = const AsyncValue.loading();
    // ref.read(notificationProvider.notifier).state = (ctx) => showTopInfo(
    //       ctx,
    //       textColor: ctx.cs.error,
    //       leading: Icon(
    //         Icons.account_balance_outlined,
    //         color: ctx.cs.error,
    //       ),
    //       title: 'Das ist ein Error',
    //     );
    // logInfo('Optimistic update: Cancel Appointment: $newValue');
    // state = AsyncValue.data(newValue);
    // await repository.put(newValue);
  }

  @override
  Future<void> closeAppointment({
    required AppointmentStatus newStatus,
    required String? comment,
  }) async {
    await repository
        .put(state.value!.copyWith(comment: comment, status: newStatus));
  }
}
