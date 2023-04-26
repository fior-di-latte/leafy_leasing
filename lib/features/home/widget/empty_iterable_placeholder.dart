import 'package:leafy_leasing/shared/base.dart';

class EmptyIterableInfo extends HookWidget {
  const EmptyIterableInfo({required this.hintText, super.key});
  final String hintText;

  @override
  Widget build(BuildContext ctx) {
    final emoji = useState(_getRandomEmoji());
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: GestureDetector(
            onTap: () => emoji.value = _getRandomEmoji(),
            child: SizedBox(
              height: 150,
              width: 150,
              child: FittedBox(
                child: Text(emoji.value),
              ),
            ).animate(key: ValueKey(emoji.value)).shake(
                  curve: Curves.easeOut,
                  delay: 180.milliseconds,
                  duration: 1.seconds,
                  hz: 2,
                ),
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

  String _getRandomEmoji() => kUnicodeFun[rnd.getInt(0, kUnicodeFun.length)];
}
