// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:leafy_leasing/features/home/provider/metas_provider.dart';
import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/data_services/hive.dart';

Future<void> bootstrap() async {
  Loggy.initLoggy();
  if (kDebugMode) {
    logWarning('Starting with DotEnv: ${dotenv.env}');
  }
  await setupHive();
  logWarning('lol');
  runApp(
    ProviderScope(
      observers: kDebugMode ? devProviderLoggers : null,
      child: WarmUp(providers: [metasStateProvider], child: App()),
    ),
  );
}
