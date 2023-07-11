/// Flow: ThemeMode -> Brightness -> Theme  (dark / light mode handling)

import 'dart:io' show Platform;

// Package imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
// Project imports:
import 'package:leafy_leasing/shared/base.dart';

part 'theme.g.dart';

const kSeedColor = Color(0xFF33A58A);
const kAppBarColor = Color(0xFF77A28B);
const kTextTheme = GoogleFonts.spaceMonoTextTheme;

@riverpod
ThemeData theme(ThemeRef ref, double scale) {
  final themeMode =
      ref.watch(settingsStateProvider.select((settings) => settings.themeMode));

  final brightness = _brightnessFromThemeMode(themeMode ?? ThemeMode.system);

  return _buildTheme(brightness, scale: scale);
}

Brightness _brightnessFromThemeMode(ThemeMode themeMode) {
  final themeModeToBrightness = {
    ThemeMode.light: Brightness.light,
    ThemeMode.dark: Brightness.dark,
    ThemeMode.system:
        WidgetsBinding.instance.platformDispatcher.platformBrightness
  };
  return themeModeToBrightness[themeMode]!;
}

ThemeData _buildTheme(Brightness brightness, {required double scale}) {
  final baseTheme = ThemeData(
    extensions: <ThemeExtension<dynamic>>[
      Insets(scale),
    ],
    useMaterial3: true,
    // appBarTheme: const AppBarTheme(color: kAppBarColor),
    colorScheme:
        ColorScheme.fromSeed(seedColor: kSeedColor, brightness: brightness),
  );

  return baseTheme.copyWith(
      textTheme: kTextTheme(baseTheme.textTheme.applyScale(scale)));
}

extension ApplyMediaQueryDependantTextScaling on TextTheme {
  TextTheme applyScale(double scale) {
    return copyWith(
      titleLarge: titleLarge?.copyWith(fontSize: 22 * scale),
      titleMedium: titleMedium?.copyWith(fontSize: 16 * scale),
      titleSmall: titleSmall?.copyWith(fontSize: 14 * scale),
      bodyLarge: bodyLarge?.copyWith(fontSize: 16 * scale),
      bodyMedium: bodyMedium?.copyWith(fontSize: 14 * scale),
      bodySmall: bodySmall?.copyWith(fontSize: 12 * scale),
      labelSmall: labelSmall?.copyWith(fontSize: 11 * scale),
      labelMedium: labelMedium?.copyWith(fontSize: 12 * scale),
      labelLarge: labelLarge?.copyWith(fontSize: 14 * scale),
      headlineSmall: headlineSmall?.copyWith(fontSize: 24 * scale),
      headlineMedium: headlineMedium?.copyWith(fontSize: 28 * scale),
      headlineLarge: headlineLarge?.copyWith(fontSize: 32 * scale),
      displaySmall: displaySmall?.copyWith(fontSize: 36 * scale),
      displayMedium: displayMedium?.copyWith(fontSize: 45 * scale),
      displayLarge: displayLarge?.copyWith(fontSize: 57 * scale),
    );
  }
}

@immutable
class Insets extends ThemeExtension<Insets> {
  const Insets(this.scale)
      : xxs = 4 * scale,
        xs = 8 * scale,
        sm = 16 * scale,
        md = 24 * scale,
        lg = 32 * scale,
        xl = 48 * scale,
        xxl = 56 * scale,
        offset = 80 * scale;
  final double scale;
  final double xxs;
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double offset;

  @override
  ThemeExtension<Insets> copyWith() {
    throw UnimplementedError();
  }

  @override
  ThemeExtension<Insets> lerp(
      covariant ThemeExtension<Insets>? other, double t) {
    if (other is! Insets) {
      return this;
    }
    return Insets(
      scale + (other.scale - scale) * t,
    );
  }
}

double scaleFromMediaQuery(BuildContext context) {
  double scaleFactor;
  final screenSize = MediaQuery.sizeOf(context);
  final shortestSide = screenSize.shortestSide;
  const tabletXl = 950;
  const tabletLg = 800;
  const tabletSm = 600;
  const phoneLg = 400;
  if (shortestSide > tabletXl) {
    scaleFactor = 1.30;
  } else if (shortestSide > tabletLg) {
    scaleFactor = 1.18;
  } else if (shortestSide > tabletSm) {
    scaleFactor = 1;
  } else if (shortestSide > phoneLg) {
    scaleFactor = .9; // phone
  } else {
    scaleFactor = .85; // small phone
  }
  return scaleFactor;
}

class AppScrollBehavior extends ScrollBehavior {
  @override
  // Add mouse drag on desktop for easier responsive testing
  Set<PointerDeviceKind> get dragDevices {
    final devices = Set<PointerDeviceKind>.from(super.dragDevices);
    if (kDebugMode) {
      devices.add(PointerDeviceKind.mouse);
    }
    return devices;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics();

  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) {
    final iOsLikeScrollbar =
        CupertinoScrollbar(controller: details.controller, child: child);
    final androidLikeScrollbar =
        RawScrollbar(controller: details.controller, child: child);
    try {
      return Platform.isAndroid ? androidLikeScrollbar : iOsLikeScrollbar;
    } catch (e) {
      return iOsLikeScrollbar;
    }
  }
}
