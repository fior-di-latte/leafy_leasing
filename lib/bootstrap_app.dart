import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:leafy_leasing/app/view/app.dart';
import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/data_services/hive.dart';

Future<void> bootstrap() async {
  Loggy.initLoggy();
  await setupHive();
  if (kDebugMode) {
    logWarning('Starting with DotEnv: ${dotenv.env.values}');
  }
  runApp(
    ProviderScope(
      observers: kDebugMode ? devProviderLoggers : null,
      child: App(),
    ),
  );
}
