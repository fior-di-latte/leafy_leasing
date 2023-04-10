import 'package:leafy_leasing/features/home/widget/custom_scaffold.dart';
import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/features/home/provider/metas_provider.dart';
import 'package:leafy_leasing/features/home/widget/custom_scaffold.dart';
import 'package:leafy_leasing/shared/base.dart';

import '../widget/appointment_listcard.dart';

@RoutePage()
class CanceledScreen extends HookConsumerWidget with UiLoggy {
  const CanceledScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    return HomeScaffold(
      body: ref.watch(metasProvider).whenFine((metas) {
        return HookBuilder(
          builder: (ctx) {
            final sorted = useSortMetas(metas.canceled);
            return ListView.builder(
              cacheExtent: 8000,
              itemCount: sorted.length,
              itemBuilder: (ctx, idx) => Stack(
                children: [
                  AppointmentListCard(
                    sorted[idx].id,
                  ),
                  const Positioned.fill(
                      child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(lPadding * 2),
                      child: Icon(
                        Icons.cancel_outlined,
                        size: 50,
                        color: Colors.red,
                      ),
                    ),
                  ))
                ],
              ),
            );
          },
        );
      }),
      title: ctx.lc.doneTitle,
    );
  }
}
