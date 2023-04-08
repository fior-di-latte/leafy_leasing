import 'package:leafy_leasing/features/home/widget/custom_scaffold.dart';
import 'package:leafy_leasing/shared/base.dart';

@RoutePage()
class DoneScreen extends HookConsumerWidget with UiLoggy {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    return HomeScaffold(body: Container(), title: ctx.lc.doneTitle,);
  }
}
