import 'package:leafy_leasing/l10n/l10n.dart';

import 'package:leafy_leasing/shared/base.dart';

import '../../shared/router/app_router.dart';

class App extends ConsumerWidget {
  App({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    return MaterialApp.router(
      theme: ref.watch(themeProvider),
      locale: ref.watch(localeProvider),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _appRouter.config(
          navigatorObservers: () => [CustomRouteObserver()],
          initialRoutes: [const HomeRoute()]),
      // routerDelegate: _appRouter.delegate(),
      // routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
