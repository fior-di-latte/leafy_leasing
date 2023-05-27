import 'package:leafy_leasing/shared/base.dart';

part 'appointment_provider.g.dart';

typedef AppointmentId = String;

@riverpod
class AppointmentState extends _$AppointmentState
    with AsyncProviderMixin<Appointment, AppointmentId> {
  @override
  FutureOr<Appointment> build(AppointmentId id) =>
      buildFromRepository(appointmentRepositoryCacheProvider, id: id);

  Future<void> cancelAppointment({
    required AppointmentStatus newStatus,
    required String? comment,
  }) =>
      optimistic(
        state.value!.copyWith(comment: comment, status: newStatus),
        id: id,
      );

  Future<void> closeAppointment({
    required AppointmentStatus newStatus,
    required String? comment,
  }) =>
      optimistic(
        state.value!.copyWith(comment: comment, status: newStatus),
        id: id,
      );
}

sealed class AppointmentRepository
    implements Repository<Appointment, AppointmentId> {
  factory AppointmentRepository.get() => switch (dotenv.backend) {
        (Backend.hive) => HiveAppointmentRepository(),
        (Backend.supabase) => throw UnimplementedError(),
      };

  Future<void> removeAppointment();
}

@riverpod
Future<(AppointmentRepository, Cache<Appointment>)> appointmentRepositoryCache(
  AppointmentRepositoryCacheRef ref,
) async {
  final cache = await ref.cache(fromJson: Appointment.fromJson);
  return (AppointmentRepository.get(), cache);
}

final class HiveAppointmentRepository
    with HiveSingletonMixin
    implements AppointmentRepository {
  @override
  Future<void> removeAppointment() {
    // TODO: implement removeAppointment
    throw UnimplementedError();
  }

  @override
  Future<Appointment> get(AppointmentId id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Stream<Appointment> listenable(AppointmentId id) {
    // TODO: implement listenable
    throw UnimplementedError();
  }

  @override
  Future<Appointment> put(Appointment item, {required AppointmentId id}) {
    // TODO: implement put
    throw UnimplementedError();
  }
}
