// Project imports:
import 'package:leafy_leasing/shared/base.dart';

class HomeScaffold extends StatelessWidget with UiLoggy {
  const HomeScaffold({
    required this.body,
    required this.title,
    this.hasFloatingButton = false,
    super.key,
  });

  final Widget body;
  final String title;
  final bool hasFloatingButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.thm.scaffoldBackgroundColor,
      floatingActionButton: hasFloatingButton
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () =>
                  loggy.info('This would open a new appointment menu.'),
            )
          : null,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => context.router.push(const SettingsRoute()),
            icon: const Icon(Icons.more_vert_outlined),
          ),
        ],
        leading: const Padding(
          padding: EdgeInsets.all(sPadding),
          child: CircleAvatar(
            foregroundImage: AssetImage(Assets.imageLogo),
          ),
        ),
        title: Text(title),
      ),
      body: body,
    );
  }
}
