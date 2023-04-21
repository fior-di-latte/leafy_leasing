import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'appointment_meta.freezed.dart';
part 'appointment_meta.g.dart';

@freezed
@HiveType(typeId: 0)
class AppointmentMeta with _$AppointmentMeta {
  factory AppointmentMeta({
    @HiveField(0) required String id,
    @HiveField(1) required DateTime date,
  }) = _AppointmentMeta;

  factory AppointmentMeta.fromJson(Map<String, dynamic> json) =>
      _$AppointmentMetaFromJson(json);
}

@freezed
@HiveType(typeId: 1)
class AppointmentMetas with _$AppointmentMetas {
  factory AppointmentMetas(
      {@HiveField(0) required List<AppointmentMeta> pending,
      @HiveField(1) required List<AppointmentMeta> canceled,
      @HiveField(2) required List<AppointmentMeta> closed,}) = _AppointmentMetas;

  factory AppointmentMetas.fromJson(Map<String, dynamic> json) =>
      _$AppointmentMetasFromJson(json);
}
