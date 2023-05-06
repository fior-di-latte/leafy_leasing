// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  return _Appointment.fromJson(json);
}

/// @nodoc
mixin _$Appointment {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  DateTime get date => throw _privateConstructorUsedError;
  @HiveField(2)
  String get customerId => throw _privateConstructorUsedError;
  @HiveField(3)
  int get durationInMinutes => throw _privateConstructorUsedError;
  @HiveField(4)
  AppointmentStatus get status => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get comment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppointmentCopyWith<Appointment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentCopyWith<$Res> {
  factory $AppointmentCopyWith(
          Appointment value, $Res Function(Appointment) then) =
      _$AppointmentCopyWithImpl<$Res, Appointment>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) DateTime date,
      @HiveField(2) String customerId,
      @HiveField(3) int durationInMinutes,
      @HiveField(4) AppointmentStatus status,
      @HiveField(5) String? comment});
}

/// @nodoc
class _$AppointmentCopyWithImpl<$Res, $Val extends Appointment>
    implements $AppointmentCopyWith<$Res> {
  _$AppointmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? customerId = null,
    Object? durationInMinutes = null,
    Object? status = null,
    Object? comment = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      durationInMinutes: null == durationInMinutes
          ? _value.durationInMinutes
          : durationInMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AppointmentStatus,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppointmentCopyWith<$Res>
    implements $AppointmentCopyWith<$Res> {
  factory _$$_AppointmentCopyWith(
          _$_Appointment value, $Res Function(_$_Appointment) then) =
      __$$_AppointmentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) DateTime date,
      @HiveField(2) String customerId,
      @HiveField(3) int durationInMinutes,
      @HiveField(4) AppointmentStatus status,
      @HiveField(5) String? comment});
}

/// @nodoc
class __$$_AppointmentCopyWithImpl<$Res>
    extends _$AppointmentCopyWithImpl<$Res, _$_Appointment>
    implements _$$_AppointmentCopyWith<$Res> {
  __$$_AppointmentCopyWithImpl(
      _$_Appointment _value, $Res Function(_$_Appointment) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? customerId = null,
    Object? durationInMinutes = null,
    Object? status = null,
    Object? comment = freezed,
  }) {
    return _then(_$_Appointment(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      durationInMinutes: null == durationInMinutes
          ? _value.durationInMinutes
          : durationInMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AppointmentStatus,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Appointment extends _Appointment {
  _$_Appointment(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.date,
      @HiveField(2) required this.customerId,
      @HiveField(3) required this.durationInMinutes,
      @HiveField(4) required this.status,
      @HiveField(5) required this.comment})
      : super._();

  factory _$_Appointment.fromJson(Map<String, dynamic> json) =>
      _$$_AppointmentFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final DateTime date;
  @override
  @HiveField(2)
  final String customerId;
  @override
  @HiveField(3)
  final int durationInMinutes;
  @override
  @HiveField(4)
  final AppointmentStatus status;
  @override
  @HiveField(5)
  final String? comment;

  @override
  String toString() {
    return 'Appointment(id: $id, date: $date, customerId: $customerId, durationInMinutes: $durationInMinutes, status: $status, comment: $comment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Appointment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.durationInMinutes, durationInMinutes) ||
                other.durationInMinutes == durationInMinutes) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, date, customerId, durationInMinutes, status, comment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppointmentCopyWith<_$_Appointment> get copyWith =>
      __$$_AppointmentCopyWithImpl<_$_Appointment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppointmentToJson(
      this,
    );
  }
}

abstract class _Appointment extends Appointment {
  factory _Appointment(
      {@HiveField(0) required final String id,
      @HiveField(1) required final DateTime date,
      @HiveField(2) required final String customerId,
      @HiveField(3) required final int durationInMinutes,
      @HiveField(4) required final AppointmentStatus status,
      @HiveField(5) required final String? comment}) = _$_Appointment;
  _Appointment._() : super._();

  factory _Appointment.fromJson(Map<String, dynamic> json) =
      _$_Appointment.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  DateTime get date;
  @override
  @HiveField(2)
  String get customerId;
  @override
  @HiveField(3)
  int get durationInMinutes;
  @override
  @HiveField(4)
  AppointmentStatus get status;
  @override
  @HiveField(5)
  String? get comment;
  @override
  @JsonKey(ignore: true)
  _$$_AppointmentCopyWith<_$_Appointment> get copyWith =>
      throw _privateConstructorUsedError;
}
