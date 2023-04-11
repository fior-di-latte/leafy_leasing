import 'dart:math';

import 'package:leafy_leasing/shared/base.dart';

class EmptyIterableInfo extends HookWidget {
  const EmptyIterableInfo({required this.hintText, Key? key}) : super(key: key);
  final String hintText;

  @override
  Widget build(BuildContext ctx) {
    final emoji =
        useMemoized(() => kUnicodeFun[Random().nextInt(kUnicodeFun.length)]);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            height: 150,
            width: 150,
            child: FittedBox(
              child: Text(emoji),
            ),
          ).animate().shake(
                curve: Curves.easeOut,
                delay: 180.milliseconds,
                duration: 1.seconds,
                hz: 2,
              ),
        ),
        Text(
          ctx.lc.noAppointmentFound,
          style: ctx.tt.bodyLarge,
        ),
        const Gap(mPadding),
        Text(
          hintText,
          style: TextStyle(color: ctx.thm.hintColor),
        )
      ],
    );
  }
}
