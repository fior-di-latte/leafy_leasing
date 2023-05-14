// Project imports:
import 'package:leafy_leasing/features/home/provider/metas_provider.dart';
import 'package:leafy_leasing/shared/base.dart';

/// this is a playground widget to rapidly test stuff
/// and is used in [HomeView].
class PlaygroundWidget extends HookConsumerWidget {
  const PlaygroundWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrecacheProvider(
      provider: metasStateProvider,
      child: Container(color: Colors.red),
    );
  }
}
