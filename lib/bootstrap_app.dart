import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:leafy_leasing/app/view/app.dart';
import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/data_services/hive.dart';

Future<void> bootstrap() async {
  Loggy.initLoggy();
  await setupHive();
  runApp(
    ProviderScope(
      observers: kDebugMode ? devProviderLoggers : null,
      child: App(),
    ),
  );
}
