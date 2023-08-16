import 'package:leafy_leasing/shared/base.dart';

part 'appointment_provider.g.dart';

typedef AppointmentId = String;

@riverpod
class AppointmentState extends _$AppointmentState
    with AsyncCachedProviderMixin<Appointment, AppointmentId> {
  @override
  FutureOr<Appointment> build(AppointmentId id) => buildFromRepository(
        appointmentRepositoryCacheProvider,
        id: id,
        strategy: FetchingStrategy.single,
      );

  Future<void> cancelAppointment({
    required AppointmentStatus newStatus,
    required String? comment,
  }) =>
      optimistic(state.value!.copyWith(comment: comment, status: newStatus));

  Future<void> closeAppointment({
    required AppointmentStatus newStatus,
    required String? comment,
  }) =>
      optimistic(state.value!.copyWith(comment: comment, status: newStatus));

  Future<void> download() async {
    await Future.delayed(3.seconds, () {});
    await repository.put(state.value!.copyWith(isOfflineAvailable: true),
        id: id);
    ref.invalidateSelf();
  }
}

sealed class AppointmentRepository
    implements Repository<Appointment, AppointmentId> {
  factory AppointmentRepository.get() => switch (dotenv.backend) {
        (Backend.hive) => HiveAppointmentRepository(),
        (Backend.supabase) => throw UnimplementedError(),
      };
}

@riverpod
Future<(AppointmentRepository, Cache<Appointment>)> appointmentRepositoryCache(
  AppointmentRepositoryCacheRef ref,
) async {
  final cache = await ref.cache(fromJson: Appointment.fromJson);
  return (AppointmentRepository.get(), cache);
}

final class HiveAppointmentRepository
    with HiveSingletonMixin<Appointment, AppointmentId>
    implements AppointmentRepository {
  @override
  late final box = client.box<Appointment>(hiveAppointments);
}
