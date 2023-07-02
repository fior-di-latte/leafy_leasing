// Project imports:
import 'package:leafy_leasing/feature/home/model/appointment_meta.dart';
import 'package:leafy_leasing/feature/home/provider/metas_provider.dart';
import 'package:leafy_leasing/feature/home/widget/appointment_listcard.dart';
import 'package:leafy_leasing/feature/home/widget/custom_scaffold.dart';
import 'package:leafy_leasing/feature/home/widget/empty_iterable_placeholder.dart';
import 'package:leafy_leasing/shared/base.dart';

@RoutePage()
class CanceledView extends HookConsumerWidget {
  const CanceledView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HomeScaffold(
      body: ref.watch(metasStateProvider).whenFine((metas) {
        final useTwoColumns = context.isWideLandscape;
        return HookBuilder(
          key: Key('canceled'),
          builder: (context) {
            final sorted = useSortMetas(metas.canceled);
            return Visibility(
              visible: sorted.isNotEmpty,
              replacement: EmptyIterableInfo(
                hintText: context.lc.canceledAppointmentsHere,
              ),
              child: GridView.builder(
                controller: ScrollController(),
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
        );
      }),
      title: context.lc.canceledTitle,
    );
  }
}
