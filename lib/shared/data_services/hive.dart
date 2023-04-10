import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:leafy_leasing/features/home/model/appointment_meta.dart';
import 'package:leafy_leasing/shared/base.dart';

const themeModeBox = 'themeModeBox';
const hiveKeyMetas = 'appointment_metas'; // both in json and in hive
const hiveKeyCustomers = 'customers'; // both in json and in hive
const hiveKeyAppointments = 'appointments'; // both in json and in hive
const hiveBoxNameMetas = 'metaBox';
const hiveBoxNameAppointments = 'appointmentsBox';
const hiveBoxNameCustomers = 'customersBox';

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(AppointmentMetasAdapter())
    ..registerAdapter(AppointmentMetaAdapter())
    ..registerAdapter(AppointmentStatusAdapter())
    ..registerAdapter(AppointmentAdapter())
    ..registerAdapter(CustomerAdapter());
  await Hive.openBox<AppointmentMetas>(hiveBoxNameMetas);
  await Hive.openBox<Appointment>(hiveBoxNameAppointments);
  await Hive.openBox<Customer>(hiveBoxNameCustomers);
  await _fillMetaBox();
  await _fillAppointmentsBox();
  await _fillCustomersBox();
}

Future<void> _fillBox<T>(
    {required String boxName,
    required String jsonAndHiveKey,
    required T Function(Map<String, dynamic> json) fromJson,
    required String jsonPath,
    bool singleKey = false}) async {
  final json = await rootBundle.loadString(jsonPath);
  final asMap = jsonDecode(json)[jsonAndHiveKey];
  final list = asMap as List<dynamic>;
  final box = Hive.box<T>(boxName);
  for (final item in list) {
    final map = item as Map<String, dynamic>;
    final entity = fromJson(map);
    final id = singleKey ? jsonAndHiveKey : map['id'] as String;
    await box.put(id, entity);
  }
}

// fill metas box
Future<void> _fillMetaBox() async {
  await _fillBox(
    boxName: hiveBoxNameMetas,
    jsonAndHiveKey: hiveKeyMetas,
    fromJson: AppointmentMetas.fromJson,
    jsonPath: AppAssets.appointmentMetas,
    singleKey: true,
  );
}

// fill appointments box
Future<void> _fillAppointmentsBox() async {
  await _fillBox(
    boxName: hiveBoxNameAppointments,
    jsonAndHiveKey: hiveKeyAppointments,
    fromJson: Appointment.fromJson,
    jsonPath: AppAssets.appointments,
  );
}

// fill customers box
Future<void> _fillCustomersBox() async {
  await _fillBox(
    boxName: hiveBoxNameCustomers,
    jsonAndHiveKey: hiveKeyCustomers,
    fromJson: Customer.fromJson,
    jsonPath: AppAssets.customers,
  );
}
