import 'package:leafy_leasing/features/home/provider/metas_provider.dart';
import 'package:leafy_leasing/features/home/widget/custom_scaffold.dart';
import 'package:leafy_leasing/features/home/widget/empty_iterable_placeholder.dart';
import 'package:leafy_leasing/shared/base.dart';

import '../widget/appointment_listcard.dart';

@RoutePage()
class DoneScreen extends HookConsumerWidget with UiLoggy {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    return HomeScaffold(
      body: ref.watch(metasProvider).whenFine((metas) {
        return HookBuilder(
          builder: (ctx) {
            final sorted = useSortMetas(metas.closed);
            return Visibility(
              visible: sorted.isNotEmpty,
              replacement: EmptyIterableInfo(
                hintText: ctx.lc.closedAppointmentsHere,
              ),
              child: ListView.builder(
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
                          Icons.check_circle_outline,
                          size: 50,
                          color: Colors.green,
                        ),
                      ),
                    ))
                  ],
                ),
              ).animate().fadeIn(),
            );
          },
        );
      }),
      title: ctx.lc.doneTitle,
    );
  }
}
