import 'package:leafy_leasing/shared/base.dart';

class BrightnessSwitches extends StatelessWidget {
  const BrightnessSwitches({Key? key}) : super(key: key);

  Widget build(BuildContext ctx) => GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          shrinkWrap: true,
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 2.5 / 1,
          children: <_ThemeCard>[
            _ThemeCard(
              themeMode: ThemeMode.system,
              icon: Icons.brightness_auto_outlined,
            ),
            _ThemeCard(
              themeMode: ThemeMode.light,
              icon: Icons.wb_sunny_outlined,
            ),
            _ThemeCard(
                themeMode: ThemeMode.dark, icon: Icons.brightness_3_outlined),
          ]);
}

class _ThemeCard extends ConsumerWidget with UiLoggy {
  const _ThemeCard({
    required this.themeMode,
    required this.icon,
  });

  final IconData icon;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeModeProvider);
    return Card(
      elevation: 2,
      color: currentThemeMode == themeMode ? ctx.cs.primary : ctx.thm.cardColor,
      shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
      child: InkWell(
        onTap: () {
          loggy.info('Pushed button to set display mode to $themeMode');
          ref.read(themeModeProvider.notifier).update((_) => themeMode);
        },
        borderRadius: kBorderRadius,
        child: Center(
          child: Icon(
            icon,
            size: 18,
            color:
                currentThemeMode != themeMode ? ctx.cs.primary : Colors.white,
          ),
        ),
      ),
    );
  }
}
