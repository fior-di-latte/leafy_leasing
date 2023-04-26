/// Flow: ThemeMode -> Brightness -> Theme  (dark / light mode handling)
import 'package:google_fonts/google_fonts.dart';
import 'package:leafy_leasing/l10n/l10n.dart';
import 'package:leafy_leasing/shared/base.dart';

const kSeedColor = Color(0xFF33A58A);
const kAppBarColor = Color(0xFF77A28B);
const kTextTheme = GoogleFonts.abhayaLibreTextTheme;

final themeProvider =
    StateProvider.autoDispose<ThemeData>(name: 'ThemeProvider', (ref) {
  final themeMode =
      ref.watch(settingsStateProvider.select((settings) => settings.themeMode));
  final brightness = _brightnessFromThemeMode(themeMode ?? ThemeMode.system);
  return _buildTheme(brightness);
});

Brightness _brightnessFromThemeMode(ThemeMode themeMode) {
  final themeModeToBrightness = {
    ThemeMode.light: Brightness.light,
    ThemeMode.dark: Brightness.dark,
    ThemeMode.system:
        WidgetsBinding.instance.platformDispatcher.platformBrightness
  };
  return themeModeToBrightness[themeMode]!;
}

ThemeData _buildTheme(Brightness brightness) {
  final baseTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(color: kAppBarColor),
    colorScheme:
        ColorScheme.fromSeed(seedColor: kSeedColor, brightness: brightness),
  );

  return baseTheme.copyWith(textTheme: kTextTheme(baseTheme.textTheme));
}
