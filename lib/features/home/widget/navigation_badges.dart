import 'package:leafy_leasing/features/home/model/appointment_meta.dart';
import 'package:leafy_leasing/features/home/provider/metas_provider.dart';
import 'package:leafy_leasing/shared/base.dart';

class NavigationBadge extends HookConsumerWidget with UiLoggy {
  const NavigationBadge(
      {this.forPending = false,
      this.forClosed = false,
      this.forCanceled = false,
      required this.child,
      Key? key})
      : super(key: key);
  final Widget child;
  final bool forPending;
  final bool forClosed;
  final bool forCanceled;
  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    return ref.watch(metasProvider).whenFine((metas) {
      final caption = _getCaption(metas);
      final isVisible = caption != '0';
      return Badge(
          label: Text(caption), isLabelVisible: isVisible, child: child);
    });
  }

  String _getCaption(AppointmentMetas metas) {
    String caption;
    if (forPending) {
      caption = metas.pending.length.toString();
    } else if (forClosed) {
      caption = metas.closed.length.toString();
    } else {
      caption = metas.canceled.length.toString();
    }
    return caption;
  }
}
