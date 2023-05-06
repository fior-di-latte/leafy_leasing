// Package imports:
// Project imports:
import 'package:leafy_leasing/l10n/l10n.dart';
import 'package:leafy_leasing/shared/base.dart';
import 'package:settings_ui/settings_ui.dart';

class LocaleSwitch extends HookConsumerWidget with UiLoggy {
  const LocaleSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeName = localeTagToNameMap(
      context,
    )[Localizations.localeOf(context).languageCode]!;

    return SettingsList(
      sections: [
        SettingsSection(
          title: Text(context.lc.common),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(Icons.language),
              title: Text(context.lc.language),
              value: Text(localeName),
              // show dialogue that lets you choose a language with radio picker
              onPressed: (context) => _showLanguagePicker(context, ref),
            )
          ],
        ),
      ],
    );
  }

  void _showLanguagePicker(BuildContext context, WidgetRef ref) =>
      showDialog<void>(
        context: context,
        builder: (context) => Container(
          alignment: Alignment.center,
          height: context.height * .4,
          child: Material(
            elevation: 8,
            color: context.thm.scaffoldBackgroundColor.withOpacity(.7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Gap(20),
                Text(
                  context.lc.chooseLanguage,
                  style: context.tt.headlineMedium,
                ),
                const Gap(20),
                ...localeTagToNameMap(context).entries.map(
                      (entry) => ListTile(
                        onTap: () => _setLanguageAndPop(ref, entry, context),
                        title: Text(entry.value),
                        leading: Radio(
                          value: entry.key,
                          groupValue:
                              Localizations.localeOf(context).languageCode,
                          onChanged: (_) =>
                              _setLanguageAndPop(ref, entry, context),
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
    BuildContext context,
  ) {
    context.router.pop();
    Future.delayed(
      200.milliseconds,
      () => ref.read(settingsStateProvider.notifier).setLocale(entry.key),
    );
  }
}
