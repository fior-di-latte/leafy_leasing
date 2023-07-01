// Project imports:
import 'package:leafy_leasing/l10n/l10n.dart';
import 'package:leafy_leasing/shared/base.dart';

class App extends ConsumerWidget {
  App({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = scaleFromMediaQuery(context);
    return MaterialApp.router(
      scrollBehavior: AppScrollBehavior(),
      theme: ref.watch(themeProvider(scale)),
      locale: ref
          .watch(settingsStateProvider.select((settings) => settings.locale)),
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        RelativeTimeLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _appRouter.config(
        navigatorObservers: () => [CustomRouteObserver()],
        deepLinkBuilder: (_) => const DeepLink([HomeRoute()]),
      ),
    );
  }
}
