import 'package:auto_route/auto_route.dart';
import 'package:leafy_leasing/features/home/home.dart';
import 'package:leafy_leasing/features/settings/view/settings_view.dart';
import 'package:leafy_leasing/shared/base.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: HomeRoute.page,
      path: '/home',
      children: [
        AutoRoute(
          page: PendingRoute.page,
          path: 'pending',
        ),
        AutoRoute(
          page: CanceledRoute.page,
          path: 'canceled',
        ),
        AutoRoute(
          page: DoneRoute.page,
          path: 'done',
        ),
      ],
    ),
    AutoRoute(page: SettingsRoute.page, path: '/settings'),
  ];
}
