// Project imports:
import 'package:leafy_leasing/features/home/model/appointment_meta.dart';
import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/repository/abstract_repository.dart';
import 'package:leafy_leasing/shared/repository/hive_repository.dart';

part 'metas_provider.g.dart';

typedef MetasRepository = AsyncRepository<AppointmentMetas>;

@riverpod
Future<Cache<AppointmentMetas>> metasCache(MetasCacheRef ref) async {
  final store = await ref.watch(isarCacheStoreProvider.future);
  return store.createLoggedCache(fromJson: AppointmentMetas.fromJson);
}

@riverpod
Future<MetasRepository> metasRepository(
  MetasRepositoryRef ref, {
  required String boxName,
  required String key,
}) async {
  final cache = await ref.watch(metasCacheProvider.future);
  return bool.parse(dotenv.get('USE_HIVE_MOCK_BACKEND'))
      ? HiveAsyncCachedRepositoryImpl<AppointmentMetas>(
          boxName,
          key: key,
          cache: cache,
        )
      : HiveAsyncCachedRepositoryImpl<AppointmentMetas>(
          boxName,
          key: key,
          cache: cache,
        );
}

@riverpod
class MetasState extends _$MetasState
    with AsyncProviderMixin<AppointmentMetas> {
  @override
  FutureOr<AppointmentMetas> build() async {
    repository = await ref.watch(
      metasRepositoryProvider(boxName: hiveMetas, key: hiveMetas).future,
    );

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
