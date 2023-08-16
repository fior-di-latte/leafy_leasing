// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppointmentAdapter extends TypeAdapter<Appointment> {
  @override
  final int typeId = 2;

  @override
  Appointment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Appointment(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      customerId: fields[2] as String,
      durationInMinutes: fields[3] as int,
      status: fields[4] as AppointmentStatus,
      comment: fields[5] as String?,
      isOfflineAvailable: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Appointment obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.customerId)
      ..writeByte(3)
      ..write(obj.durationInMinutes)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.comment)
      ..writeByte(6)
      ..write(obj.isOfflineAvailable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppointmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AppointmentStatusAdapter extends TypeAdapter<AppointmentStatus> {
  @override
  final int typeId = 5;

  @override
  AppointmentStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AppointmentStatus.pending;
      case 1:
        return AppointmentStatus.doneSuccessful;
      case 2:
        return AppointmentStatus.doneAborted;
      case 3:
        return AppointmentStatus.canceledUs;
      case 4:
        return AppointmentStatus.canceledCustomer;
      default:
        return AppointmentStatus.pending;
    }
  }

  @override
  void write(BinaryWriter writer, AppointmentStatus obj) {
    switch (obj) {
      case AppointmentStatus.pending:
        writer.writeByte(0);
        break;
      case AppointmentStatus.doneSuccessful:
        writer.writeByte(1);
        break;
      case AppointmentStatus.doneAborted:
        writer.writeByte(2);
        break;
      case AppointmentStatus.canceledUs:
        writer.writeByte(3);
        break;
      case AppointmentStatus.canceledCustomer:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppointmentStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Appointment _$$_AppointmentFromJson(Map<String, dynamic> json) =>
    _$_Appointment(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      customerId: json['customerId'] as String,
      durationInMinutes: json['durationInMinutes'] as int,
      status: $enumDecode(_$AppointmentStatusEnumMap, json['status']),
      comment: json['comment'] as String?,
      isOfflineAvailable: json['isOfflineAvailable'] as bool,
    );

Map<String, dynamic> _$$_AppointmentToJson(_$_Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'customerId': instance.customerId,
      'durationInMinutes': instance.durationInMinutes,
      'status': _$AppointmentStatusEnumMap[instance.status]!,
      'comment': instance.comment,
      'isOfflineAvailable': instance.isOfflineAvailable,
    };

const _$AppointmentStatusEnumMap = {
  AppointmentStatus.pending: 'pending',
  AppointmentStatus.doneSuccessful: 'doneSuccessful',
  AppointmentStatus.doneAborted: 'doneAborted',
  AppointmentStatus.canceledUs: 'canceledUs',
  AppointmentStatus.canceledCustomer: 'canceledCustomer',
};
