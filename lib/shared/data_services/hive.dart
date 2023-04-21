import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:leafy_leasing/features/home/model/appointment_meta.dart';
import 'package:leafy_leasing/shared/base.dart';

/// IMPORTANT: the names below are used
/// 1. as a Hive Box name
/// 2. as the top level key in the respective json
/// Convention: Variable name == Value (String)
const hiveMetas = 'hiveMetas';
const hiveAppointments = 'hiveAppointments';
const hiveCustomers = 'hiveCustomers';

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(AppointmentMetasAdapter())
    ..registerAdapter(AppointmentMetaAdapter())
    ..registerAdapter(AppointmentStatusAdapter())
    ..registerAdapter(AppointmentAdapter())
    ..registerAdapter(CustomerAdapter());
  await Hive.openBox<AppointmentMetas>(hiveMetas);
  await Hive.openBox<Appointment>(hiveAppointments);
  await Hive.openBox<Customer>(hiveCustomers);
  await _fillMetaBox();
  await _fillAppointmentsBox();
  await _fillCustomersBox();
}

Future<void> _fillBox<T>(
    {required String boxName,
    required T Function(Map<String, dynamic> json) fromJson,
    required String jsonPath,
    bool singleKey = false,}) async {
  final json = await rootBundle.loadString(jsonPath);
  final asMap = jsonDecode(json)[boxName];
  final list = asMap as List<dynamic>;
  final box = Hive.box<T>(boxName);
  for (final item in list) {
    final map = item as Map<String, dynamic>;
    final entity = fromJson(map);
    final id = singleKey ? boxName : map['id'] as String;
    await box.put(id, entity);
  }
}

// fill metas box
Future<void> _fillMetaBox() async {
  await _fillBox(
    boxName: hiveMetas,
    fromJson: AppointmentMetas.fromJson,
    jsonPath: AppAssets.appointmentMetas,
    singleKey: true,
  );
}

// fill appointments box
Future<void> _fillAppointmentsBox() async {
  await _fillBox(
    boxName: hiveAppointments,
    fromJson: Appointment.fromJson,
    jsonPath: AppAssets.appointments,
  );
}

// fill customers box
Future<void> _fillCustomersBox() async {
  await _fillBox(
    boxName: hiveCustomers,
    fromJson: Customer.fromJson,
    jsonPath: AppAssets.customers,
  );
}
