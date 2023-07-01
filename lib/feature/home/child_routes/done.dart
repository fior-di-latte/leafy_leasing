// Project imports:
import 'package:leafy_leasing/feature/home/provider/metas_provider.dart';
import 'package:leafy_leasing/feature/home/widget/appointment_listcard.dart';
import 'package:leafy_leasing/feature/home/widget/custom_scaffold.dart';
import 'package:leafy_leasing/feature/home/widget/dart_rive.dart';
import 'package:leafy_leasing/feature/home/widget/empty_iterable_placeholder.dart';
import 'package:leafy_leasing/shared/base.dart';

@RoutePage()
class DoneView extends HookConsumerWidget {
  const DoneView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HomeScaffold(
      body: ref.watch(metasStateProvider).whenFine((metas) {
        final useTwoColumns = context.isWideLandscape;
        return Stack(
          children: [
            HookBuilder(
              builder: (context) {
                final sorted = useSortMetas(metas.closed);
                return Visibility(
                  visible: sorted.isNotEmpty,
                  replacement: EmptyIterableInfo(
                    hintText: context.lc.closedAppointmentsHere,
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: useTwoColumns ? 2 : 1,
                      childAspectRatio: useTwoColumns ? 1.8 : 2,
                    ),
                    itemCount: sorted.length,
                    itemBuilder: (context, idx) => AppointmentListCard(
                      sorted[idx].id,
                    ),
                    cacheExtent: 8000,
                  ).animate().fadeIn(),
                );
              },
            ),
            const FlutterRiveAnimation()
                .animate(delay: 3.seconds)
                .fadeIn(duration: 3.seconds),
          ],
        );
      }),
      title: context.lc.doneTitle,
    );
  }
}
