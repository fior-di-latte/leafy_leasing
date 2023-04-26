import 'package:leafy_leasing/features/home/provider/metas_provider.dart';
import 'package:leafy_leasing/shared/base.dart';

/// this is a playground widget to rapidly test stuff
/// and is used in [HomeScreen].
class PlaygroundWidget extends HookConsumerWidget with UiLoggy {
  const PlaygroundWidget({super.key});

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    logWarning('lol');
    return PrecacheProvider(
      provider: metasProvider,
      child: Container(color: Colors.red),
    );
  }
}
