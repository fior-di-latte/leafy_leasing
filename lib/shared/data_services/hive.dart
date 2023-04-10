import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:leafy_leasing/features/home/model/appointment_meta.dart';
import 'package:leafy_leasing/shared/base.dart';

const themeModeBox = 'themeModeBox';
const hiveKeyMetas = 'appointment_metas'; // both in json and in hive
const hiveBoxNameMetas = 'metaBox';

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AppointmentMetasAdapter());
  Hive.registerAdapter(AppointmentMetaAdapter());
  await Hive.openBox<AppointmentMetas>('metaBox');
  await _fillMetaBox();
}

// read json '/assets/appointment_metas', get dictionary from key 'appointmentMetas'
Future<void> _fillMetaBox() async {
  final appointmentMetas =
      await rootBundle.loadString(AppAssets.appointmentMetas);
  final asMap = jsonDecode(appointmentMetas)[hiveKeyMetas];
  final metas = AppointmentMetas.fromJson(asMap as Map<String, dynamic>);
  await Hive.box<AppointmentMetas>(hiveBoxNameMetas).put(hiveKeyMetas, metas);
}
