import '../shared/base.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

// null means the system locale
final localeProvider =
    StateProvider<Locale?>(name: 'LocaleProvider', (ref) => null);

void setLocale(WidgetRef ref, String languageTag) =>
    ref.read(localeProvider.notifier).update((_) => _getLocale(languageTag));

Locale? _getLocale(String? languageCode) =>
    (languageCode != null) ? Locale(languageCode) : null;

Map<String, String> localeTagToNameMap(BuildContext ctx) =>
    {'en': ctx.lc.english, 'de': ctx.lc.german};

// ref.watch(localeProvider)?.languageCode ??
// Localizations.localeOf(ctx).languageCode
