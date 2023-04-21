import 'package:leafy_leasing/features/home/model/appointment_meta.dart';
import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/data_services/hive.dart';

final metasProvider = StateNotifierProvider.autoDispose<MetasNotifier,
    AsyncValue<AppointmentMetas>>(MetasNotifier.new);

class MetasNotifier extends HiveAsyncStateNotifier<AppointmentMetas> {
  MetasNotifier(super.ref)
      : super(boxName: hiveMetas, key: hiveMetas);

  Future<void> cancelAppointment(String id) async {
    // add Meta to canceld, remove from pending
    final date = ref.read(appointmentProvider(id)).value!.date;
    await repository.put(state.value!.copyWith(canceled: [
      ...state.value!.canceled,
      AppointmentMeta(id: id, date: date)
    ], pending: [
      ...state.value!.pending.where((element) => element.id != id),
    ],),);
  }

  Future<void> closeAppointment(String id) async {
    final date = ref.read(appointmentProvider(id)).value!.date;
    await repository.put(state.value!.copyWith(closed: [
      ...state.value!.closed,
      AppointmentMeta(id: id, date: date)
    ], pending: [
      ...state.value!.pending.where((element) => element.id != id),
    ],),);
  }
}
