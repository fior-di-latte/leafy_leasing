// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerAdapter extends TypeAdapter<Customer> {
  @override
  final int typeId = 3;

  @override
  Customer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Customer(
      id: fields[0] as String,
      companyName: fields[1] as String,
      email: fields[2] as String,
      nameContact: fields[3] as String,
      phone: fields[4] as String,
      address: fields[5] as String,
      city: fields[6] as String,
      zip: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Customer obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.companyName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.nameContact)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.city)
      ..writeByte(7)
      ..write(obj.zip);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Customer _$$_CustomerFromJson(Map<String, dynamic> json) => _$_Customer(
      id: json['id'] as String,
      companyName: json['companyName'] as String,
      email: json['email'] as String,
      nameContact: json['nameContact'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      zip: json['zip'] as String,
    );

Map<String, dynamic> _$$_CustomerToJson(_$_Customer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyName': instance.companyName,
      'email': instance.email,
      'nameContact': instance.nameContact,
      'phone': instance.phone,
      'address': instance.address,
      'city': instance.city,
      'zip': instance.zip,
    };
