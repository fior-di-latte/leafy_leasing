import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'appointment.freezed.dart';
part 'appointment.g.dart';

@HiveType(typeId: 5)
enum AppointmentStatus {
  @HiveField(0)
  pending,
  @HiveField(1)
  doneSuccessful,
  @HiveField(2)
  doneAborted,
  @HiveField(3)
  canceledUs,
  @HiveField(4)
  canceledCustomer
}

@freezed
@HiveType(typeId: 2)
class Appointment with _$Appointment {
  factory Appointment(
      {@HiveField(0) required String id,
      @HiveField(1) required DateTime date,
      @HiveField(2) required String customerId,
      @HiveField(3) required int durationInMinutes,
      @HiveField(4) required AppointmentStatus status,
      @HiveField(5) required String? comment}) = _Appointment;

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
