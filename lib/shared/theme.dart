import 'package:google_fonts/google_fonts.dart';
import 'package:leafy_leasing/shared/base.dart';

const kSeedColor = Color(0xFF33A58A);
const kAppBarColor = Color(0xFF77A28B);

final themeProvider = StateProvider<ThemeData>(
    name: 'ThemeProvider', (ref) => buildTheme(Brightness.light));

ThemeData buildTheme(Brightness brightness) {
  final baseTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(color: kAppBarColor),
    colorScheme: ColorScheme.fromSeed(seedColor: kSeedColor),
    brightness: brightness,
  );

  return baseTheme.copyWith(
    textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
  );
}
