// Package imports:
import 'package:flash/flash.dart';

// Project imports:
import 'package:leafy_leasing/shared/base.dart';

void showTopInfo(
  BuildContext context, {
  required Widget leading,
  required String title,
  Color? surfaceTintColor,
  Color? textColor = Colors.white,
  FlashBehavior style = FlashBehavior.fixed,
  String? description,
  Duration? duration,
  VoidCallback? onTap,
  bool showProgressIndicator = false,
}) {
  showFlash<bool>(
    context: context,
    transitionDuration: 460.milliseconds,
    reverseTransitionDuration: 350.milliseconds,
    duration: duration ?? 3.seconds,
    builder: (context, controller) => GestureDetector(
      onTap: () => controller.dismiss(),
      child: FlashBar(
        controller: controller,
        surfaceTintColor: surfaceTintColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: kBorderRadius.bottomLeft),
        ),
        reverseAnimationCurve: Curves.easeIn,
        position: FlashPosition.top,
        padding: const EdgeInsets.symmetric(
          horizontal: mPadding,
          vertical: lPadding,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 50),
        icon: Padding(padding: const EdgeInsets.all(mPadding), child: leading),
        shouldIconPulse: false,
        titleTextStyle: context.tt.titleLarge!.copyWith(color: textColor),
        title: Text(title),
        showProgressIndicator: showProgressIndicator,
        content: const SizedBox.shrink(),
      ),
    ),
  );
}
