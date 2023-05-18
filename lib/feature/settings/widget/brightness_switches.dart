// Project imports:
import 'package:leafy_leasing/shared/base.dart';

class BrightnessSwitches extends StatelessWidget {
  const BrightnessSwitches({super.key});

  @override
  Widget build(BuildContext context) => GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        shrinkWrap: true,
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 2.5 / 1,
        children: const <_ThemeCard>[
          _ThemeCard(
            themeMode: ThemeMode.system,
            icon: Icons.brightness_auto_outlined,
          ),
          _ThemeCard(
            themeMode: ThemeMode.light,
            icon: Icons.wb_sunny_outlined,
          ),
          _ThemeCard(
            themeMode: ThemeMode.dark,
            icon: Icons.brightness_3_outlined,
          ),
        ],
      );
}

class _ThemeCard extends ConsumerWidget {
  const _ThemeCard({
    required this.themeMode,
    required this.icon,
  });

  final IconData icon;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref
        .watch(settingsStateProvider.select((settings) => settings.themeMode));
    return Card(
      elevation: 2,
      color: currentThemeMode == themeMode
          ? context.cs.primary
          : context.thm.cardColor,
      shape: const RoundedRectangleBorder(borderRadius: kBorderRadius),
      child: InkWell(
        onTap: () {
          logger.i('Pushed button to set display mode to $themeMode');
          ref.read(settingsStateProvider.notifier).setThemeMode(themeMode);
        },
        borderRadius: kBorderRadius,
        child: Center(
          child: Icon(
            icon,
            size: 18,
            color: currentThemeMode != themeMode
                ? context.cs.primary
                : Colors.white,
          ),
        ),
      ),
    );
  }
}
