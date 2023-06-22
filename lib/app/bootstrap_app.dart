// Dart imports:
import 'dart:async';

// Project imports:
import 'package:leafy_leasing/feature/home/provider/metas_provider.dart';
import 'package:leafy_leasing/shared/base.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';

Future<void> bootstrap() async {
  if (kDebugMode) {
    logger.w('Starting with DotEnv: ${dotenv.env}');
  }
  _initFonts();
  WidgetsFlutterBinding.ensureInitialized();
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

void _initFonts() {
  GoogleFonts.config.allowRuntimeFetching = true;
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString(Assets.googleFontsOFL);
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
}
