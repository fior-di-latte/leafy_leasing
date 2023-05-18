// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppointmentMeta _$AppointmentMetaFromJson(Map<String, dynamic> json) {
  return _AppointmentMeta.fromJson(json);
}

/// @nodoc
mixin _$AppointmentMeta {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  DateTime get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppointmentMetaCopyWith<AppointmentMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentMetaCopyWith<$Res> {
  factory $AppointmentMetaCopyWith(
          AppointmentMeta value, $Res Function(AppointmentMeta) then) =
      _$AppointmentMetaCopyWithImpl<$Res, AppointmentMeta>;
  @useResult
  $Res call({@HiveField(0) String id, @HiveField(1) DateTime date});
}

/// @nodoc
class _$AppointmentMetaCopyWithImpl<$Res, $Val extends AppointmentMeta>
    implements $AppointmentMetaCopyWith<$Res> {
  _$AppointmentMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppointmentMetaCopyWith<$Res>
    implements $AppointmentMetaCopyWith<$Res> {
  factory _$$_AppointmentMetaCopyWith(
          _$_AppointmentMeta value, $Res Function(_$_AppointmentMeta) then) =
      __$$_AppointmentMetaCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@HiveField(0) String id, @HiveField(1) DateTime date});
}

/// @nodoc
class __$$_AppointmentMetaCopyWithImpl<$Res>
    extends _$AppointmentMetaCopyWithImpl<$Res, _$_AppointmentMeta>
    implements _$$_AppointmentMetaCopyWith<$Res> {
  __$$_AppointmentMetaCopyWithImpl(
      _$_AppointmentMeta _value, $Res Function(_$_AppointmentMeta) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
  }) {
    return _then(_$_AppointmentMeta(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppointmentMeta implements _AppointmentMeta {
  _$_AppointmentMeta(
      {@HiveField(0) required this.id, @HiveField(1) required this.date});

  factory _$_AppointmentMeta.fromJson(Map<String, dynamic> json) =>
      _$$_AppointmentMetaFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final DateTime date;

  @override
  String toString() {
    return 'AppointmentMeta(id: $id, date: $date)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppointmentMeta &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppointmentMetaCopyWith<_$_AppointmentMeta> get copyWith =>
      __$$_AppointmentMetaCopyWithImpl<_$_AppointmentMeta>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppointmentMetaToJson(
      this,
    );
  }
}

abstract class _AppointmentMeta implements AppointmentMeta {
  factory _AppointmentMeta(
      {@HiveField(0) required final String id,
      @HiveField(1) required final DateTime date}) = _$_AppointmentMeta;

  factory _AppointmentMeta.fromJson(Map<String, dynamic> json) =
      _$_AppointmentMeta.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  DateTime get date;
  @override
  @JsonKey(ignore: true)
  _$$_AppointmentMetaCopyWith<_$_AppointmentMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

AppointmentMetas _$AppointmentMetasFromJson(Map<String, dynamic> json) {
  return _AppointmentMetas.fromJson(json);
}

/// @nodoc
mixin _$AppointmentMetas {
  @HiveField(0)
  List<AppointmentMeta> get pending => throw _privateConstructorUsedError;
  @HiveField(1)
  List<AppointmentMeta> get canceled => throw _privateConstructorUsedError;
  @HiveField(2)
  List<AppointmentMeta> get closed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppointmentMetasCopyWith<AppointmentMetas> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentMetasCopyWith<$Res> {
  factory $AppointmentMetasCopyWith(
          AppointmentMetas value, $Res Function(AppointmentMetas) then) =
      _$AppointmentMetasCopyWithImpl<$Res, AppointmentMetas>;
  @useResult
  $Res call(
      {@HiveField(0) List<AppointmentMeta> pending,
      @HiveField(1) List<AppointmentMeta> canceled,
      @HiveField(2) List<AppointmentMeta> closed});
}

/// @nodoc
class _$AppointmentMetasCopyWithImpl<$Res, $Val extends AppointmentMetas>
    implements $AppointmentMetasCopyWith<$Res> {
  _$AppointmentMetasCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pending = null,
    Object? canceled = null,
    Object? closed = null,
  }) {
    return _then(_value.copyWith(
      pending: null == pending
          ? _value.pending
          : pending // ignore: cast_nullable_to_non_nullable
              as List<AppointmentMeta>,
      canceled: null == canceled
          ? _value.canceled
          : canceled // ignore: cast_nullable_to_non_nullable
              as List<AppointmentMeta>,
      closed: null == closed
          ? _value.closed
          : closed // ignore: cast_nullable_to_non_nullable
              as List<AppointmentMeta>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppointmentMetasCopyWith<$Res>
    implements $AppointmentMetasCopyWith<$Res> {
  factory _$$_AppointmentMetasCopyWith(
          _$_AppointmentMetas value, $Res Function(_$_AppointmentMetas) then) =
      __$$_AppointmentMetasCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) List<AppointmentMeta> pending,
      @HiveField(1) List<AppointmentMeta> canceled,
      @HiveField(2) List<AppointmentMeta> closed});
}

/// @nodoc
class __$$_AppointmentMetasCopyWithImpl<$Res>
    extends _$AppointmentMetasCopyWithImpl<$Res, _$_AppointmentMetas>
    implements _$$_AppointmentMetasCopyWith<$Res> {
  __$$_AppointmentMetasCopyWithImpl(
      _$_AppointmentMetas _value, $Res Function(_$_AppointmentMetas) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pending = null,
    Object? canceled = null,
    Object? closed = null,
  }) {
    return _then(_$_AppointmentMetas(
      pending: null == pending
          ? _value._pending
          : pending // ignore: cast_nullable_to_non_nullable
              as List<AppointmentMeta>,
      canceled: null == canceled
          ? _value._canceled
          : canceled // ignore: cast_nullable_to_non_nullable
              as List<AppointmentMeta>,
      closed: null == closed
          ? _value._closed
          : closed // ignore: cast_nullable_to_non_nullable
              as List<AppointmentMeta>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppointmentMetas implements _AppointmentMetas {
  _$_AppointmentMetas(
      {@HiveField(0) required final List<AppointmentMeta> pending,
      @HiveField(1) required final List<AppointmentMeta> canceled,
      @HiveField(2) required final List<AppointmentMeta> closed})
      : _pending = pending,
        _canceled = canceled,
        _closed = closed;

  factory _$_AppointmentMetas.fromJson(Map<String, dynamic> json) =>
      _$$_AppointmentMetasFromJson(json);

  final List<AppointmentMeta> _pending;
  @override
  @HiveField(0)
  List<AppointmentMeta> get pending {
    if (_pending is EqualUnmodifiableListView) return _pending;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pending);
  }

  final List<AppointmentMeta> _canceled;
  @override
  @HiveField(1)
  List<AppointmentMeta> get canceled {
    if (_canceled is EqualUnmodifiableListView) return _canceled;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_canceled);
  }

  final List<AppointmentMeta> _closed;
  @override
  @HiveField(2)
  List<AppointmentMeta> get closed {
    if (_closed is EqualUnmodifiableListView) return _closed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_closed);
  }

  @override
  String toString() {
    return 'AppointmentMetas(pending: $pending, canceled: $canceled, closed: $closed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppointmentMetas &&
            const DeepCollectionEquality().equals(other._pending, _pending) &&
            const DeepCollectionEquality().equals(other._canceled, _canceled) &&
            const DeepCollectionEquality().equals(other._closed, _closed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_pending),
      const DeepCollectionEquality().hash(_canceled),
      const DeepCollectionEquality().hash(_closed));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppointmentMetasCopyWith<_$_AppointmentMetas> get copyWith =>
      __$$_AppointmentMetasCopyWithImpl<_$_AppointmentMetas>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppointmentMetasToJson(
      this,
    );
  }
}

abstract class _AppointmentMetas implements AppointmentMetas {
  factory _AppointmentMetas(
          {@HiveField(0) required final List<AppointmentMeta> pending,
          @HiveField(1) required final List<AppointmentMeta> canceled,
          @HiveField(2) required final List<AppointmentMeta> closed}) =
      _$_AppointmentMetas;

  factory _AppointmentMetas.fromJson(Map<String, dynamic> json) =
      _$_AppointmentMetas.fromJson;

  @override
  @HiveField(0)
  List<AppointmentMeta> get pending;
  @override
  @HiveField(1)
  List<AppointmentMeta> get canceled;
  @override
  @HiveField(2)
  List<AppointmentMeta> get closed;
  @override
  @JsonKey(ignore: true)
  _$$_AppointmentMetasCopyWith<_$_AppointmentMetas> get copyWith =>
      throw _privateConstructorUsedError;
}
