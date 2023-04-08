import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:leafy_leasing/shared/base.dart';
import 'package:loggy/loggy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app/view/app.dart';

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

// TODO
setupHive() {}
