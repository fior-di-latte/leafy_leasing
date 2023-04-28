// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Project imports:
import 'package:leafy_leasing/shared/base.dart';

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

// I would usually use "super power enums" from the newer Dart version,
// but that seems incompatible with the Hive annotation.
extension AddExtraInfo on AppointmentStatus {
  IconData get icon {
    switch (this) {
      case AppointmentStatus.pending:
        return Icons.more_horiz_outlined;
      case AppointmentStatus.doneSuccessful:
        return Icons.check_circle_outline;

      case AppointmentStatus.doneAborted:
        return Icons.check_circle_outline;

      case AppointmentStatus.canceledUs:
        return Icons.cancel_outlined;

      case AppointmentStatus.canceledCustomer:
        return Icons.cancel_outlined;
    }
  }

  String labelText(BuildContext context) {
    switch (this) {
      case AppointmentStatus.pending:
        return 'pending'; // case not relevant in current UI
      case AppointmentStatus.doneSuccessful:
        return context.lc.hasBeenSuccessful;
      case AppointmentStatus.doneAborted:
        return context.lc.hasBeenAborted;

      case AppointmentStatus.canceledUs:
        return context.lc.weHaveCanceled;

      case AppointmentStatus.canceledCustomer:
        return context.lc.customerHasCanceled;
    }
  }
}

@freezed
@HiveType(typeId: 2)
class Appointment with _$Appointment {
  factory Appointment({
    @HiveField(0) required String id,
    @HiveField(1) required DateTime date,
    @HiveField(2) required String customerId,
    @HiveField(3) required int durationInMinutes,
    @HiveField(4) required AppointmentStatus status,
    @HiveField(5) required String? comment,
  }) = _Appointment;

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  // this is needed for freezed in order to be able to write methods
  Appointment._();

  bool get hasComment {
    if (comment == null) return false;
    return comment!.isNotEmpty;
  }

  bool get isDone =>
      status == AppointmentStatus.doneSuccessful ||
      status == AppointmentStatus.doneAborted;
  bool get isCanceled =>
      status == AppointmentStatus.canceledUs ||
      status == AppointmentStatus.canceledCustomer;
  bool get isPending => status == AppointmentStatus.pending;
}
