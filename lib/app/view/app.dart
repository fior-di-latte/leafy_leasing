import 'package:leafy_leasing/l10n/l10n.dart';

import 'package:leafy_leasing/shared/base.dart';

class App extends ConsumerWidget {
  App({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    return MaterialApp.router(
      theme: ref.watch(themeProvider),
      locale: ref
          .watch(settingsStateProvider.select((settings) => settings.locale)),
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        RelativeTimeLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _appRouter.config(
        navigatorObservers: () => [CustomRouteObserver()],
        initialRoutes: [const HomeRoute()],
      ),
    );
  }
}
