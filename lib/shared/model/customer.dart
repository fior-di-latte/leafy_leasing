// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
@HiveType(typeId: 3)
class Customer with _$Customer {
  factory Customer({
    @HiveField(0) required String id,
    @HiveField(1) required String companyName,
    @HiveField(2) required String email,
    @HiveField(3) required String nameContact,
    @HiveField(4) required String phone,
    @HiveField(5) required String address,
    @HiveField(6) required String city,
    @HiveField(7) required String zip,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}
