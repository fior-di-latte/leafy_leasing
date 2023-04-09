import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment.freezed.dart';
part 'appointment.g.dart';

enum AppointmentStatus {
  pending,
  doneSuccessful,
  doneAborted,
  canceledUs,
  canceledCustomer
}

@freezed
class Appointment with _$Appointment {
  factory Appointment(
      {required String id,
      required DateTime date,
      required String customerId,
      required int durationInMinutes,
      required AppointmentStatus status}) = _Appointment;

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  // this is needed for freezed in order to be able to write methods
  Appointment._();

  bool get isDone =>
      status == AppointmentStatus.doneSuccessful ||
      status == AppointmentStatus.doneAborted;
  bool get isCanceled =>
      status == AppointmentStatus.canceledUs ||
      status == AppointmentStatus.canceledCustomer;
  bool get isPending => status == AppointmentStatus.pending;
}
