import 'package:easy_debounce/easy_throttle.dart';
import 'package:flash/flash.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:leafy_leasing/shared/base.dart';

import 'package:leafy_leasing/shared/provider/internet_connection_provider.dart';

class AllNotificationListener extends ConsumerWidget {
  const AllNotificationListener({required this.child, super.key});

  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen(internetConnectionProvider, (_, status) {
        status.whenData((status) {
          if (status == InternetConnectionStatus.disconnected) {
            showTopInfo(context, leading: Text('lol'), title: 'rofl');
          }
        });
      })
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
