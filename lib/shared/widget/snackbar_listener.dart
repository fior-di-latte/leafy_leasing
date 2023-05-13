import 'package:easy_debounce/easy_throttle.dart';
import 'package:leafy_leasing/shared/base.dart';

import 'package:leafy_leasing/shared/provider/internet_connection_provider.dart';

class SnackbarListener extends ConsumerWidget with UiLoggy {
  const SnackbarListener({required this.child, super.key});

  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..watch(internetConnectionProvider)
      ..listen(
        notificationProvider,
        (_, snackbarBuilder) => EasyThrottle.throttle(
          snackbarBuilder.type.toString(),
          snackbarBuilder.type.throttleDuration,
          () => snackbarBuilder.builder(context),
        ),
      );
    return child;
  }
}
