// Project imports:
import 'package:leafy_leasing/features/home/provider/metas_provider.dart';
import 'package:leafy_leasing/features/home/widget/appointment_listcard.dart';
import 'package:leafy_leasing/features/home/widget/custom_scaffold.dart';
import 'package:leafy_leasing/features/home/widget/empty_iterable_placeholder.dart';
import 'package:leafy_leasing/shared/base.dart';

@RoutePage()
class DoneScreen extends HookConsumerWidget with UiLoggy {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HomeScaffold(
      body: ref.watch(metasStateProvider).whenFine((metas) {
        return HookBuilder(
          builder: (context) {
            final sorted = useSortMetas(metas.closed);
            return Visibility(
              visible: sorted.isNotEmpty,
              replacement: EmptyIterableInfo(
                hintText: context.lc.closedAppointmentsHere,
              ),
              child: ListView.builder(
                cacheExtent: 8000,
                itemCount: sorted.length,
                itemBuilder: (context, idx) => Stack(
                  children: [
                    AppointmentListCard(
                      sorted[idx].id,
                    ),
                    const Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.all(lPadding * 2),
                          child: Icon(
                            Icons.check_circle_outline,
                            size: 50,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ).animate().fadeIn(),
            );
          },
        );
      }),
      title: context.lc.doneTitle,
    );
  }
}
