import 'package:leafy_leasing/features/home/widget/navigation_badges.dart';
import 'package:leafy_leasing/shared/base.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    return SnackbarListener(
      child: AutoTabsRouter.tabBar(
        routes: const [PendingRoute(), DoneRoute(), CanceledRoute()],
        builder: (ctx, child, _) {
          final tabsRouter = AutoTabsRouter.of(ctx);
          return Column(
            children: [
              Expanded(child: child),
              SizedBox(
                height: 60,
                child: BottomNavigationBar(
                  backgroundColor: ctx.thm.scaffoldBackgroundColor,
                  iconSize: 20,
                  showSelectedLabels: false,
                  elevation: 4,
                  showUnselectedLabels: false,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: NavigationBadge(
                        forPending: true,
                        child: Icon(Icons.home),
                      ),
                      label: 'Settings',
                    ),
                    BottomNavigationBarItem(
                      icon: NavigationBadge(
                        forClosed: true,
                        child: Icon(Icons.check_box_outlined),
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: NavigationBadge(
                        forCanceled: true,
                        child: Icon(Icons.cancel_outlined),
                      ),
                      label: 'Messages',
                    ),
                  ],
                  currentIndex: tabsRouter.activeIndex,
                  onTap: tabsRouter.setActiveIndex,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
