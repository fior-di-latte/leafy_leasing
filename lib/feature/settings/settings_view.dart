// Project imports:
import 'package:leafy_leasing/feature/settings/widget/brightness_switches.dart';
import 'package:leafy_leasing/feature/settings/widget/loc_switch.dart';
import 'package:leafy_leasing/shared/base.dart';

@RoutePage()
class SettingsView extends HookConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text(context.lc.settings),
      ),
      body: const Column(
        children: [BrightnessSwitches(), Expanded(child: LocaleSwitch())],
      ),
    );
  }
}
