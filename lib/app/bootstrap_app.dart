// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:leafy_leasing/features/home/provider/metas_provider.dart';
import 'package:leafy_leasing/shared/base.dart';

Future<void> bootstrap() async {
  if (kDebugMode) {
    logger.w('Starting with DotEnv: ${dotenv.env}');
  }
  await setupHive();
  runApp(
    ProviderScope(
      observers: kDebugMode ? devProviderLoggers : null,
      child: WarmUp(providers: [metasStateProvider], child: App()),
    ),
  );
}
