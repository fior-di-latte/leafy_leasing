// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:leafy_leasing/feature/home/provider/metas_provider.dart';
import 'package:leafy_leasing/shared/base.dart';
import 'package:overlay_support/overlay_support.dart';

Future<void> bootstrap() async {
  if (kDebugMode) {
    logger.w('Starting with DotEnv: ${dotenv.env}');
  }
  await setupHive();
  runApp(
    OverlaySupport.global(
      child: ProviderScope(
        observers: kDebugMode ? devProviderLoggers : null,
        child: WarmUp(providers: [metasStateProvider], child: App()),
      ),
    ),
  );
}
