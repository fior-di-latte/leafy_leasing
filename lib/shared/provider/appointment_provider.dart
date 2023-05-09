// Dart imports:
import 'dart:async';

// Project imports:
import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/repository/abstract_repository.dart';
import 'package:leafy_leasing/shared/repository/hive_repository.dart';

part 'appointment_provider.g.dart';

typedef AppointmentRepository = AsyncCachedRepository<Appointment>;
// TODO(Felix):  Newer riverpod version will allow for generic families.
// which will allow to remove this boilerplate
// also, the ref.onDispose in [AppointmentState] below will be obsolete
// because it can also be handled in the generic family

@riverpod
Future<Cache<Appointment>> appointmentCache(AppointmentCacheRef ref) async {
  final store = await ref.watch(isarCacheStoreProvider.future);
  return store.createLoggedCache(fromJson: Appointment.fromJson);
}

@riverpod
Future<AppointmentRepository> appointmentRepository(
  AppointmentRepositoryRef ref, {
  required String key,
}) async {
  final cache = await ref.watch(appointmentCacheProvider.future);
  return dotenv.get('USE_HIVE_MOCK_BACKEND') == 'true'
      ? HiveAsyncCachedRepositoryImpl<Appointment>(
          hiveAppointments,
          key: key,
          cache: cache,
        )
      : HiveAsyncCachedRepositoryImpl<Appointment>(
          hiveAppointments,
          key: key,
          cache: cache,
        );
}

@riverpod
class AppointmentState extends _$AppointmentState
    with AsyncRepositoryMixin<Appointment> {
  @override
  FutureOr<Appointment> build(String id) async {
    repository = await ref.watch(
      appointmentRepositoryProvider(key: id).future,
    );
    ref.onDispose(() => repository.dispose());

    return buildFromStream();
  }

  Future<void> cancelAppointment({
    required AppointmentStatus newStatus,
    required String? comment,
  }) =>
      optimisticPut(
        state.value!.copyWith(comment: comment, status: newStatus),
      );

  Future<void> closeAppointment({
    required AppointmentStatus newStatus,
    required String? comment,
  }) =>
      optimisticPut(
        state.value!.copyWith(comment: comment, status: newStatus),
      );
}
