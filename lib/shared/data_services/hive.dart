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
const hiveSettings = 'hiveSettings';

Future<void> setupHive() async {
  await Hive.initFlutter();
  await _maybeFlushHive();
  Hive
    ..registerAdapter(AppointmentMetasAdapter())
    ..registerAdapter(AppointmentMetaAdapter())
    ..registerAdapter(AppointmentStatusAdapter())
    ..registerAdapter(AppointmentAdapter())
    ..registerAdapter(CustomerAdapter())
    ..registerAdapter(ThemeModeAdapter())
    ..registerAdapter(SettingsAdapter());
  await Hive.openBox<AppointmentMetas>(hiveMetas);
  await Hive.openBox<Appointment>(hiveAppointments);
  await Hive.openBox<Customer>(hiveCustomers);
  await Hive.openBox<Settings>(hiveSettings);
  await _fillMetaBox();
  await _fillAppointmentsBox();
  await _fillCustomersBox();
}

Future<void> _maybeFlushHive() async {
  if (dotenv.get('FLUSH_HIVE') == 'true') {
    logWarning('Flushing Hive...');
    await Hive.deleteFromDisk();
  }
}

Future<void> _fillBox<T>({
  required String boxName,
  required T Function(Map<String, dynamic> json) fromJson,
  required String jsonPath,
  bool singleKey = false,
}) async {
  final box = Hive.box<T>(boxName);

  final json = await rootBundle.loadString(jsonPath);
  final list = jsonDecode(json)[boxName] as List<dynamic>;

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
    jsonPath: Assets.mockDataAppointmentMetas,
    singleKey: true,
  );
}

// fill appointments box
Future<void> _fillAppointmentsBox() async {
  await _fillBox(
    boxName: hiveAppointments,
    fromJson: Appointment.fromJson,
    jsonPath: Assets.mockDataAppointments,
  );
}

// fill customers box
Future<void> _fillCustomersBox() async {
  await _fillBox(
    boxName: hiveCustomers,
    fromJson: Customer.fromJson,
    jsonPath: Assets.mockDataCustomers,
  );
}

class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  final typeId = 6;

  @override
  ThemeMode read(BinaryReader reader) {
    return ThemeMode.values[reader.read() as int];
  }

  @override
  void write(BinaryWriter writer, ThemeMode themeMode) {
    writer.write(ThemeMode.values.indexOf(themeMode));
  }
}
