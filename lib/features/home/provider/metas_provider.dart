// Project imports:
import 'package:leafy_leasing/features/home/model/appointment_meta.dart';
import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/data_services/hive.dart';
import 'package:leafy_leasing/shared/repository/abstract_repository.dart';
import 'package:leafy_leasing/shared/repository/hive_repository.dart';

part 'metas_provider.g.dart';

typedef MetasRepository = HiveAsyncRepository<AppointmentMetas>;

@riverpod
MetasRepository metasRepository(
  Ref ref, {
  required String boxName,
  required String key,
}) {
  return dotenv.get('USE_HIVE_MOCK_BACKEND') == 'true'
      ? HiveAsyncRepositoryImpl<AppointmentMetas>(boxName, key: key)
      : HiveAsyncRepositoryImpl<AppointmentMetas>(boxName, key: key);
}

@riverpod
class MetasState extends _$MetasState
    with AsyncRepositoryMixin<AppointmentMetas> {
  @override
  FutureOr<AppointmentMetas> build() async {
    repository =
        ref.watch(metasRepositoryProvider(boxName: hiveMetas, key: hiveMetas));

    return buildFromStream();
  }

  Future<void> cancelAppointment(String id) {
    final date = ref.read(appointmentStateProvider(id)).value!.date;
    final newValue = state.value!.copyWith(
      canceled: [...state.value!.canceled, AppointmentMeta(id: id, date: date)],
      pending: [
        ...state.value!.pending.where((element) => element.id != id),
      ],
    );
    return optimisticPut(newValue);
  }

  Future<void> closeAppointment(String id) {
    final date = ref.read(appointmentStateProvider(id)).value!.date;
    final newValue = state.value!.copyWith(
      closed: [...state.value!.closed, AppointmentMeta(id: id, date: date)],
      pending: [
        ...state.value!.pending.where((element) => element.id != id),
      ],
    );
    return optimisticPut(newValue);
  }
}
