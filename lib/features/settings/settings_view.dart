// Project imports:
import 'package:leafy_leasing/features/settings/widget/brightness_switches.dart';
import 'package:leafy_leasing/features/settings/widget/loc_switch.dart';
import 'package:leafy_leasing/shared/base.dart';

@RoutePage()
class SettingsView extends HookConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.lc.settings),
      ),
      body: Column(
        children: const [BrightnessSwitches(), Expanded(child: LocaleSwitch())],
      ),
    );
  }
}
