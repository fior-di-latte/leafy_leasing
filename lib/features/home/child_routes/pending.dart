import 'package:leafy_leasing/features/home/provider/home_provider.dart';
import 'package:leafy_leasing/features/home/widget/appointment_listcard.dart';
import 'package:leafy_leasing/features/home/widget/custom_scaffold.dart';
import 'package:leafy_leasing/shared/base.dart';

@RoutePage()
class PendingScreen extends HookConsumerWidget with UiLoggy {
  const PendingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx, WidgetRef ref) => HomeScaffold(
        body: ref.watch(metasProvider).whenFine((metas) => ListView.builder(
              itemCount: metas.pending.length,
              itemBuilder: (ctx, idx) => AppointmentListCard(
                metas.pending[idx].id,
              ),
            ).animate().fadeIn()),
        title: ctx.lc.appTitle,
        hasFloatingButton: true,
      );
}
