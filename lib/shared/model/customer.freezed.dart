// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return _Customer.fromJson(json);
}

/// @nodoc
mixin _$Customer {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get companyName => throw _privateConstructorUsedError;
  @HiveField(2)
  String get email => throw _privateConstructorUsedError;
  @HiveField(3)
  String get nameContact => throw _privateConstructorUsedError;
  @HiveField(4)
  String get phone => throw _privateConstructorUsedError;
  @HiveField(5)
  String get address => throw _privateConstructorUsedError;
  @HiveField(6)
  String get city => throw _privateConstructorUsedError;
  @HiveField(7)
  String get zip => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerCopyWith<Customer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerCopyWith<$Res> {
  factory $CustomerCopyWith(Customer value, $Res Function(Customer) then) =
      _$CustomerCopyWithImpl<$Res, Customer>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String companyName,
      @HiveField(2) String email,
      @HiveField(3) String nameContact,
      @HiveField(4) String phone,
      @HiveField(5) String address,
      @HiveField(6) String city,
      @HiveField(7) String zip});
}

/// @nodoc
class _$CustomerCopyWithImpl<$Res, $Val extends Customer>
    implements $CustomerCopyWith<$Res> {
  _$CustomerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyName = null,
    Object? email = null,
    Object? nameContact = null,
    Object? phone = null,
    Object? address = null,
    Object? city = null,
    Object? zip = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      nameContact: null == nameContact
          ? _value.nameContact
          : nameContact // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      zip: null == zip
          ? _value.zip
          : zip // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CustomerCopyWith<$Res> implements $CustomerCopyWith<$Res> {
  factory _$$_CustomerCopyWith(
          _$_Customer value, $Res Function(_$_Customer) then) =
      __$$_CustomerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String companyName,
      @HiveField(2) String email,
      @HiveField(3) String nameContact,
      @HiveField(4) String phone,
      @HiveField(5) String address,
      @HiveField(6) String city,
      @HiveField(7) String zip});
}

/// @nodoc
class __$$_CustomerCopyWithImpl<$Res>
    extends _$CustomerCopyWithImpl<$Res, _$_Customer>
    implements _$$_CustomerCopyWith<$Res> {
  __$$_CustomerCopyWithImpl(
      _$_Customer _value, $Res Function(_$_Customer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyName = null,
    Object? email = null,
    Object? nameContact = null,
    Object? phone = null,
    Object? address = null,
    Object? city = null,
    Object? zip = null,
  }) {
    return _then(_$_Customer(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      nameContact: null == nameContact
          ? _value.nameContact
          : nameContact // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      zip: null == zip
          ? _value.zip
          : zip // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Customer implements _Customer {
  _$_Customer(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.companyName,
      @HiveField(2) required this.email,
      @HiveField(3) required this.nameContact,
      @HiveField(4) required this.phone,
      @HiveField(5) required this.address,
      @HiveField(6) required this.city,
      @HiveField(7) required this.zip});

  factory _$_Customer.fromJson(Map<String, dynamic> json) =>
      _$$_CustomerFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String companyName;
  @override
  @HiveField(2)
  final String email;
  @override
  @HiveField(3)
  final String nameContact;
  @override
  @HiveField(4)
  final String phone;
  @override
  @HiveField(5)
  final String address;
  @override
  @HiveField(6)
  final String city;
  @override
  @HiveField(7)
  final String zip;

  @override
  String toString() {
    return 'Customer(id: $id, companyName: $companyName, email: $email, nameContact: $nameContact, phone: $phone, address: $address, city: $city, zip: $zip)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Customer &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.nameContact, nameContact) ||
                other.nameContact == nameContact) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.zip, zip) || other.zip == zip));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, companyName, email,
      nameContact, phone, address, city, zip);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CustomerCopyWith<_$_Customer> get copyWith =>
      __$$_CustomerCopyWithImpl<_$_Customer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CustomerToJson(
      this,
    );
  }
}

abstract class _Customer implements Customer {
  factory _Customer(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String companyName,
      @HiveField(2) required final String email,
      @HiveField(3) required final String nameContact,
      @HiveField(4) required final String phone,
      @HiveField(5) required final String address,
      @HiveField(6) required final String city,
      @HiveField(7) required final String zip}) = _$_Customer;

  factory _Customer.fromJson(Map<String, dynamic> json) = _$_Customer.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get companyName;
  @override
  @HiveField(2)
  String get email;
  @override
  @HiveField(3)
  String get nameContact;
  @override
  @HiveField(4)
  String get phone;
  @override
  @HiveField(5)
  String get address;
  @override
  @HiveField(6)
  String get city;
  @override
  @HiveField(7)
  String get zip;
  @override
  @JsonKey(ignore: true)
  _$$_CustomerCopyWith<_$_Customer> get copyWith =>
      throw _privateConstructorUsedError;
}
