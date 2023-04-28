import 'package:leafy_leasing/l10n/l10n.dart';
import 'package:leafy_leasing/shared/base.dart';
import 'package:settings_ui/settings_ui.dart';

class LocaleSwitch extends HookConsumerWidget with UiLoggy {
  const LocaleSwitch({super.key});

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    final localeName =
        localeTagToNameMap(ctx)[Localizations.localeOf(ctx).languageCode]!;

    return SettingsList(
      sections: [
        SettingsSection(
          title: Text(ctx.lc.common),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(Icons.language),
              title: Text(ctx.lc.language),
              value: Text(localeName),
              // show dialogue that lets you choose a language with radio picker
              onPressed: (ctx) => _showLanguagePicker(ctx, ref),
            )
          ],
        ),
      ],
    );
  }

  void _showLanguagePicker(BuildContext ctx, WidgetRef ref) => showDialog<void>(
        barrierDismissible: true,
        context: ctx,
        builder: (ctx) => Container(
          alignment: Alignment.center,
          height: ctx.height * .4,
          child: Material(
            elevation: 8,
            color: ctx.thm.scaffoldBackgroundColor.withOpacity(.7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Gap(20),
                Text(
                  ctx.lc.chooseLanguage,
                  style: ctx.tt.headlineMedium,
                ),
                const Gap(20),
                ...localeTagToNameMap(ctx).entries.map(
                      (entry) => ListTile(
                        onTap: () => _setLanguageAndPop(ref, entry, ctx),
                        title: Text(entry.value),
                        leading: Radio(
                          value: entry.key,
                          groupValue: Localizations.localeOf(ctx).languageCode,
                          onChanged: (_) => _setLanguageAndPop(ref, entry, ctx),
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
      );

  void _setLanguageAndPop(
    WidgetRef ref,
    MapEntry<String, String> entry,
    BuildContext ctx,
  ) {
    ctx.router.pop();
    Future.delayed(
      200.milliseconds,
      () => ref.read(settingsStateProvider.notifier).setLocale(entry.key),
    );
  }
}
