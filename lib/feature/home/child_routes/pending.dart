// Project imports:
import 'package:leafy_leasing/feature/home/model/appointment_meta.dart';
import 'package:leafy_leasing/feature/home/provider/metas_provider.dart';
import 'package:leafy_leasing/feature/home/widget/appointment_listcard.dart';
import 'package:leafy_leasing/feature/home/widget/custom_scaffold.dart';
import 'package:leafy_leasing/feature/home/widget/empty_iterable_placeholder.dart';
import 'package:leafy_leasing/shared/base.dart';

@RoutePage()
class PendingView extends HookConsumerWidget {
  const PendingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => HomeScaffold(
        body: ref.watch(metasStateProvider).whenFine((metas) {
          return HookBuilder(
            builder: (context) {
              final useTwoColumns = context.isWideLandscape;
              final sorted = useSortMetas(metas.pending);
              return Visibility(
                visible: sorted.isNotEmpty,
                replacement: EmptyIterableInfo(
                  hintText: context.lc.pendingAppointmentsHere,
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
                ),
              ).animate(key: ValueKey(useTwoColumns)).fadeIn();
            },
          );
        }),
        title: context.lc.appTitle,
        hasFloatingButton: true,
      );
}

List<AppointmentMeta> useSortMetas(List<AppointmentMeta> metas) {
  return useMemoized(
    () {
      final modifiable = [...metas];
      return modifiable..sort((a, b) => a.date.compareTo(b.date));
    },
    [metas],
  );
}
