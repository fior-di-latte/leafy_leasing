// Project imports:
import 'package:leafy_leasing/feature/home/widget/custom_scaffold.dart';
import 'package:leafy_leasing/feature/home/widget/navigation_badges.dart';
import 'package:leafy_leasing/feature/home/widget/settings_button_navrail.dart';
import 'package:leafy_leasing/shared/base.dart';

@RoutePage()
class HomeView extends HookConsumerWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return PlaygroundWidget();
    final isLandscape = context.isLandscape;
    return AllNotificationListener(
      child: AutoTabsRouter.tabBar(
        scrollDirection: isLandscape ? Axis.vertical : Axis.horizontal,
        routes: const [PendingRoute(), DoneRoute(), CanceledRoute()],
        builder: (context, child, _) {
          final tabsRouter = AutoTabsRouter.of(context);
          final isWideLandscape = context.isWideLandscape;
          return Stack(
            children: [
              AnimatedBubbleBackground(
                backgroundColor: context.thm.scaffoldBackgroundColor,
              ),
              if (isLandscape)
                Row(
                  children: [
                    NavigationRail(
                      backgroundColor: Colors.transparent,
                      leading: Transform.scale(
                        scale: context.scaleFactor,
                        child: HomeScaffold.logo,
                      ),
                      trailing: Expanded(
                        child: SettingsButtonNavRail(
                          isWideLandscape: isWideLandscape,
                        ),
                      ),
                      // minWidth: 200,
                      minExtendedWidth: 240,
                      extended: isWideLandscape,
                      onDestinationSelected: tabsRouter.setActiveIndex,
                      destinations: [
                        // home destination
                        NavigationRailDestination(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          icon: const Icon(
                            Icons.home,
                          ),
                          label: Text(context.lc.pendingTitle),
                        ),
                        NavigationRailDestination(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          icon: const NavigationBadge(
                            forClosed: true,
                            child: Icon(Icons.check_box_outlined),
                          ),
                          label: Text(context.lc.closeAppointmentTitle),
                        ),
                        NavigationRailDestination(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          icon: const NavigationBadge(
                            forCanceled: true,
                            child: Icon(Icons.cancel_outlined),
                          ),
                          label: Text(context.lc.canceledTitle),
                        ),
                      ],
                      selectedIndex: tabsRouter.activeIndex,
                    ),
                    Expanded(child: child),
                  ],
                )
              else
                Column(
                  children: [
                    Expanded(child: child),
                    BottomNavigationBar(
                      backgroundColor: context.thm.scaffoldBackgroundColor,
                      iconSize: 20,
                      showSelectedLabels: false,
                      elevation: 4,
                      showUnselectedLabels: false,
                      items: <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: const NavigationBadge(
                            forPending: true,
                            child: Icon(Icons.home),
                          ),
                          label: context.lc.pendingTitle,
                        ),
                        BottomNavigationBarItem(
                          icon: const NavigationBadge(
                            forClosed: true,
                            child: Icon(Icons.check_box_outlined),
                          ),
                          label: context.lc.closeAppointmentTitle,
                        ),
                        BottomNavigationBarItem(
                          icon: const NavigationBadge(
                            forCanceled: true,
                            child: Icon(Icons.cancel_outlined),
                          ),
                          label: context.lc.canceledTitle,
                        ),
                      ],
                      currentIndex: tabsRouter.activeIndex,
                      onTap: tabsRouter.setActiveIndex,
                    )
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
