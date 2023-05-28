import 'package:leafy_leasing/feature/home/model/appointment_meta.dart';
import 'package:leafy_leasing/shared/base.dart';

part 'metas_provider.g.dart';

typedef UniqueMetasId = String;

@riverpod
class MetasState extends _$MetasState
    with AsyncProviderMixin<AppointmentMetas, UniqueMetasId> {
  @override
  FutureOr<AppointmentMetas> build() => buildFromRepository(
        metasRepositoryCacheProvider,
        id: hiveMetas,
        strategy: FetchingStrategy.stream,
      );

  Future<void> cancelAppointment(AppointmentId id) {
    final date = ref.read(appointmentStateProvider(id)).value!.date;
    final newValue = state.value!.copyWith(
      canceled: [...state.value!.canceled, AppointmentMeta(id: id, date: date)],
      pending: [
        ...state.value!.pending.where((element) => element.id != id),
      ],
    );
    return optimistic(newValue, id: id);
  }

  Future<void> closeAppointment(AppointmentId id) {
    final date = ref.read(appointmentStateProvider(id)).value!.date;
    final newValue = state.value!.copyWith(
      closed: [...state.value!.closed, AppointmentMeta(id: id, date: date)],
      pending: [
        ...state.value!.pending.where((element) => element.id != id),
      ],
    );
    return optimistic(newValue, id: id);
  }
}

sealed class MetasRepository
    implements Repository<AppointmentMetas, UniqueMetasId> {
  factory MetasRepository.get() => switch (dotenv.backend) {
        (Backend.hive) => HiveMetasRepository(),
        (Backend.supabase) => throw UnimplementedError(),
      };
}

@riverpod
Future<(MetasRepository, Cache<AppointmentMetas>)> metasRepositoryCache(
  MetasRepositoryCacheRef ref,
) async {
  final cache = await ref.cache(fromJson: AppointmentMetas.fromJson);
  return (MetasRepository.get(), cache);
}

final class HiveMetasRepository
    with HiveSingletonMixin<AppointmentMetas, UniqueMetasId>
    implements MetasRepository {
  @override
  late final box = client.box<AppointmentMetas>(hiveMetas);

  @override
  Stream<AppointmentMetas> listenable(UniqueMetasId id) {
    // TODO: implement listenable
    throw UnimplementedError();
  }
}
