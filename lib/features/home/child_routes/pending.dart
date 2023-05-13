// Project imports:
import 'package:leafy_leasing/features/home/model/appointment_meta.dart';
import 'package:leafy_leasing/features/home/provider/metas_provider.dart';
import 'package:leafy_leasing/features/home/widget/appointment_listcard.dart';
import 'package:leafy_leasing/features/home/widget/custom_scaffold.dart';
import 'package:leafy_leasing/features/home/widget/empty_iterable_placeholder.dart';
import 'package:leafy_leasing/shared/base.dart';

@RoutePage()
class PendingView extends HookConsumerWidget with UiLoggy {
  const PendingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => HomeScaffold(
        body: ref.watch(metasStateProvider).whenFine((metas) {
          return HookBuilder(
            builder: (context) {
              final sorted = useSortMetas(metas.pending);
              return Visibility(
                visible: sorted.isNotEmpty,
                replacement: EmptyIterableInfo(
                  hintText: context.lc.pendingAppointmentsHere,
                ),
                child: ListView.builder(
                  cacheExtent: 8000,
                  itemCount: sorted.length,
                  itemBuilder: (context, idx) => AppointmentListCard(
                    sorted[idx].id,
                  ),
                ).animate().fadeIn(),
              );
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
