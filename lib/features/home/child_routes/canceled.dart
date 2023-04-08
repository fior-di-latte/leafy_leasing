import 'package:leafy_leasing/features/home/widget/custom_scaffold.dart';
import 'package:leafy_leasing/shared/base.dart';

@RoutePage()
class CanceledScreen extends HookConsumerWidget with UiLoggy {
  const CanceledScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    return HomeScaffold(body: Container(), title: ctx.lc.canceledTitle);
  }
}
