// Project imports:
import 'package:leafy_leasing/shared/base.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({
    required this.body,
    required this.title,
    this.hasFloatingButton = false,
    super.key,
  });

  static const logo = Padding(
    padding: EdgeInsets.all(sPadding),
    child: CircleAvatar(
      foregroundImage: AssetImage(Assets.imageLogo),
    ),
  );

  final Widget body;
  final String title;
  final bool hasFloatingButton;

  @override
  Widget build(BuildContext context) {
    final isLandscape = context.isLandscape;
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: hasFloatingButton
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () =>
                  logger.i('This would open a new appointment menu.'),
            )
          : null,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        actions: isLandscape
            ? null
            : [
                IconButton(
                  onPressed: () => context.router.push(const SettingsRoute()),
                  icon: const Icon(Icons.more_vert_outlined),
                )
              ],
        leading: isLandscape ? null : logo,
        title: isLandscape
            ? Align(
                alignment: Alignment.centerLeft,
                child: Text(title),
              )
            : Text(title),
      ),
      body: Opacity(opacity: .88, child: body),
    );
  }
}
