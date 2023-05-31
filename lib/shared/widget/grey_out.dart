import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/provider/internet_connection_provider.dart';

class GreyOut extends StatelessWidget {
  const GreyOut({
    required this.child,
    this.greyOut = true,
    this.ignorePointer = true,
    super.key,
  });
  final bool greyOut;
  final bool ignorePointer;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: 180.milliseconds,
      child: greyOut
          ? IgnorePointer(
              ignoring: ignorePointer,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  context.thm.disabledColor,
                  BlendMode.modulate,
                ),
                child: child,
              ),
            )
          : child,
    );
  }
}

extension GreyOutWhenOffline on Widget {
  Widget greyOutWhenOffline() => Consumer(
        builder: (ctx, ref, _) => GreyOut(
          greyOut: ref.watch(internetConnectionProvider).value ==
              InternetConnectionStatus.disconnected,
          child: this,
        ),
      );
}
