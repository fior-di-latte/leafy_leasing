import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/data_services/hive.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

// null means the system locale
// final localeProvider =
//     StateProvider<Locale?>(name: 'LocaleProvider', (ref) => null);

final settingsProvider =
    StateNotifierProvider.autoDispose<SettingsNotifier, Settings>(
  name: 'SettingsProvider',
  SettingsNotifier.new,
);

class SettingsNotifier extends HiveNotifier<Settings> {
  SettingsNotifier(
    super.ref,
  ) : super(boxName: hiveSettings, key: hiveSettings, defaultValue: Settings());

  void setLocale(String localeTag) =>
      repository.put(state.copyWith(localeTag: localeTag));

  void setThemeMode(ThemeMode themeMode) =>
      repository.put(state.copyWith(themeMode: themeMode));
}

Map<String, String> localeTagToNameMap(BuildContext ctx) =>
    {'en': ctx.lc.english, 'de': ctx.lc.german};

// ref.watch(localeProvider)?.languageCode ??
// Localizations.localeOf(ctx).languageCode
