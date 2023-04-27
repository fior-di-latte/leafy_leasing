import 'dart:async';

import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/data_services/hive.dart';
import 'package:leafy_leasing/shared/repository/abstract_repository.dart';

import '../repository/hive_repository.dart';

part 'appointment_provider.g.dart';

typedef AppointmentRepository = HiveAsyncStreamRepository<Appointment>;

/// TODO newer riverpod version will allow for generic families.
/// which will allow to remove this boilerplate
/// also, the ref.onDispose in [AppointmentState] below will be obsolete
/// because it can also be handled in the generic family
@riverpod
AppointmentRepository appointmentRepository(
  Ref ref, {
  required String boxName,
  required String key,
}) {
  return dotenv.get('USE_HIVE_MOCK_BACKEND') == 'true'
      ? HiveRepositoryAsyncStreamImpl<Appointment>(boxName, key: key)
      : HiveRepositoryAsyncStreamImpl<Appointment>(boxName, key: key);
}

@riverpod
class AppointmentState extends _$AppointmentState
    with AsyncRepositoryMixin<Appointment> {
  @override
  FutureOr<Appointment> build(String id) async {
    repository = ref.watch(
      appointmentRepositoryProvider(boxName: hiveAppointments, key: id),
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
