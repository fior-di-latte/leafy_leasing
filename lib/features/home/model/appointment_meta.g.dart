// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_meta.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppointmentMetaAdapter extends TypeAdapter<AppointmentMeta> {
  @override
  final int typeId = 0;

  @override
  AppointmentMeta read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppointmentMeta(
      id: fields[0] as String,
      date: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AppointmentMeta obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppointmentMetaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AppointmentMetasAdapter extends TypeAdapter<AppointmentMetas> {
  @override
  final int typeId = 1;

  @override
  AppointmentMetas read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppointmentMetas(
      pending: (fields[0] as List).cast<AppointmentMeta>(),
      canceled: (fields[1] as List).cast<AppointmentMeta>(),
      closed: (fields[2] as List).cast<AppointmentMeta>(),
    );
  }

  @override
  void write(BinaryWriter writer, AppointmentMetas obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.pending)
      ..writeByte(1)
      ..write(obj.canceled)
      ..writeByte(2)
      ..write(obj.closed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppointmentMetasAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppointmentMeta _$$_AppointmentMetaFromJson(Map<String, dynamic> json) =>
    _$_AppointmentMeta(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$_AppointmentMetaToJson(_$_AppointmentMeta instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
    };

_$_AppointmentMetas _$$_AppointmentMetasFromJson(Map<String, dynamic> json) =>
    _$_AppointmentMetas(
      pending: (json['pending'] as List<dynamic>)
          .map((e) => AppointmentMeta.fromJson(e as Map<String, dynamic>))
          .toList(),
      canceled: (json['canceled'] as List<dynamic>)
          .map((e) => AppointmentMeta.fromJson(e as Map<String, dynamic>))
          .toList(),
      closed: (json['closed'] as List<dynamic>)
          .map((e) => AppointmentMeta.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_AppointmentMetasToJson(_$_AppointmentMetas instance) =>
    <String, dynamic>{
      'pending': instance.pending,
      'canceled': instance.canceled,
      'closed': instance.closed,
    };
