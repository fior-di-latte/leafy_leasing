import 'package:leafy_leasing/counter/counter.dart';
import 'package:leafy_leasing/l10n/l10n.dart';

import 'package:leafy_leasing/shared/base.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    return MaterialApp(
      theme: ref.watch(themeProvider),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}
