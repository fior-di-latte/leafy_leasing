import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/data_services/hive.dart';

final appointmentProvider = StateNotifierProvider.autoDispose
    .family<AppointmentNotifier, AsyncValue<Appointment>, String>(
        name: 'AppointmentProvider',
        (ref, id) => AppointmentNotifier(ref, id: id));

class AppointmentNotifier extends HiveAsyncStateNotifier<Appointment> {
  AppointmentNotifier(AutoDisposeRef ref, {required String id})
      : super(ref, boxName: hiveAppointments, key: id);

  Future<void> cancelAppointment({
    required AppointmentStatus newStatus,
    required String? comment,
  }) async {
    assert(newStatus == AppointmentStatus.canceledUs ||
        newStatus == AppointmentStatus.canceledCustomer);

    repository.put(state.value!.copyWith(comment: comment, status: newStatus));
  }

  Future<void> closeAppointment({
    required AppointmentStatus newStatus,
    required String? comment,
  }) async {
    assert(newStatus == AppointmentStatus.doneSuccessful ||
        newStatus == AppointmentStatus.doneAborted);
    repository.put(state.value!.copyWith(comment: comment, status: newStatus));
  }
}
