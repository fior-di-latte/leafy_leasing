import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class Customer with _$Customer {
  factory Customer(
      {required String id,
      required String name,
      required String email,
      required String nameContact,
      required String phone,
      required String address,
      required String city,
      required String state,
      required String zip,
      required DateTime createdAt}) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}
