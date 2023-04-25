import 'package:leafy_leasing/features/home/model/appointment_meta.dart';
import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/data_services/hive.dart';

final metasProvider = StateNotifierProvider.autoDispose<MetasNotifier,
    AsyncValue<AppointmentMetas>>(name: 'MetasProvider', MetasNotifier.new);

abstract class MetasNotifier
    implements StateNotifier<AsyncValue<AppointmentMetas>> {
  factory MetasNotifier(AutoDisposeRef ref) =>
      dotenv.get('USE_HIVE_MOCK_BACKEND') == 'true'
          ? MetasHiveNotifier(ref)
          : MetasHiveNotifier(ref);

  Future<void> cancelAppointment(String id);
  Future<void> closeAppointment(String id);
}

class MetasHiveNotifier extends HiveAsyncStateNotifier<AppointmentMetas>
    implements MetasNotifier {
  MetasHiveNotifier(super.ref) : super(boxName: hiveMetas, key: hiveMetas);

  @override
  Future<void> cancelAppointment(String id) async {
    // add Meta to canceled, remove from pending
    final date = ref.read(appointmentProvider(id)).value!.date;
    final newValue = state.value!.copyWith(
      canceled: [...state.value!.canceled, AppointmentMeta(id: id, date: date)],
      pending: [
        ...state.value!.pending.where((element) => element.id != id),
      ],
    );
    logInfo('Optimistic update: Cancel Appointment: $newValue');
    // todo triple update, not ideal: optimistic, in data source and manually after data write is successful
    state = AsyncValue.data(newValue);
    state = await AsyncValue.guard(() => repository.put(newValue));
  }

  @override
  Future<void> closeAppointment(String id) async {
    final date = ref.read(appointmentProvider(id)).value!.date;
    await repository.put(
      state.value!.copyWith(
        closed: [...state.value!.closed, AppointmentMeta(id: id, date: date)],
        pending: [
          ...state.value!.pending.where((element) => element.id != id),
        ],
      ),
    );
  }
}
