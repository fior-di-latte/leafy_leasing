import 'package:leafy_leasing/features/settings/widget/brightness_switches.dart';
import 'package:leafy_leasing/features/settings/widget/loc_switch.dart';
import 'package:leafy_leasing/shared/base.dart';

@RoutePage()
class SettingsScreen extends HookConsumerWidget with UiLoggy {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ctx.lc.settings),
      ),
      body: Column(
        children: const [BrightnessSwitches(), Expanded(child: LocaleSwitch())],
      ),
    );
  }
}
