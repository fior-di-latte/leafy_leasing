import 'package:leafy_leasing/shared/base.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

Map<String, String> localeTagToNameMap(BuildContext ctx) =>
    {'en': ctx.lc.english, 'de': ctx.lc.german};
