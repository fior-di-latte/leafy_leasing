import 'package:leafy_leasing/features/home/widget/appointment_listcard.dart';
import 'package:leafy_leasing/features/home/widget/custom_scaffold.dart';
import 'package:leafy_leasing/shared/base.dart';

@RoutePage()
class PendingScreen extends HookConsumerWidget with UiLoggy {
  const PendingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    return HomeScaffold(
      body: ListView.builder(
          itemBuilder: (ctx, idx) => AppointmentListCard('lol')),
      title: ctx.lc.appTitle,
      hasFloatingButton: true,
    );
  }
}
