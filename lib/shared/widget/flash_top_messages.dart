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
  VoidCallback? onTap,
}) {
  showFlash<bool>(
    context: context,
    transitionDuration: 460.milliseconds,
    reverseTransitionDuration: 350.milliseconds,
    duration: 3.seconds,
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
          vertical: sPadding,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 50),
        icon: Padding(padding: const EdgeInsets.all(mPadding), child: leading),
        shouldIconPulse: false,
        titleTextStyle: context.tt.titleLarge!.copyWith(color: textColor),
        title: Text(title),
        content: const SizedBox.shrink(),
      ),
    ),
  );
}
