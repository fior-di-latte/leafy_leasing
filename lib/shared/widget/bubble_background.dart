import 'dart:math';

import 'package:blobs/blobs.dart';

import 'package:leafy_leasing/shared/base.dart';

class AnimatedBubbleBackground extends HookWidget {
  const AnimatedBubbleBackground({
    super.key,
    this.onlyBottomBubbles = true,
    this.delayInMilliseconds = 1,
    this.backgroundColor,
    this.baseDurationInMilliseconds = 5500,
    this.fadeInDurationInMilliseconds = 1800,
    this.slideInDurationInMilliseconds = 1200,
    this.bubbleColor,
  });
  final bool onlyBottomBubbles;
  final int delayInMilliseconds;
  final int baseDurationInMilliseconds;
  final int fadeInDurationInMilliseconds;
  final int slideInDurationInMilliseconds;
  final Color? bubbleColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final rng = Random();
    final numberBlobs = useRef(onlyBottomBubbles ? 12 : 8);
    final sizes = useRef(
      List.generate(numberBlobs.value, (index) => 200 + rng.nextInt(500)),
    );
    final sizesMax = sizes.value.reduce(max);
    final sizesNormalized = sizes.value.map((e) => e / sizesMax);

    final opacities = useRef(
      List.generate(
        numberBlobs.value,
        (index) => (1.2 - sizesNormalized.toList()[index]) * 0.1,
      ),
    );

    final blurs = useRef(
      List.generate(
        numberBlobs.value,
        (index) => sizesNormalized.toList()[index] * 6,
      ),
    );

    final durations = useRef(
      List.generate(
        numberBlobs.value,
        (index) =>
            ((sizesNormalized.toList()[index]) * baseDurationInMilliseconds)
                .milliseconds,
      ),
    );

    final xCoords = useRef(
      List.generate(
        numberBlobs.value,
        (index) => context.width * rng.nextInt(25) / 60,
      ),
    );
    final yCoords = useRef(
      List.generate(
        numberBlobs.value,
        (index) =>
            context.height *
            (onlyBottomBubbles
                ? rng.nextInt(60) / 100
                : rng.nextInt(120) / 100),
      ),
    );

    final blobs = useRef(
      List.generate(
        numberBlobs.value,
        (index) => Positioned(
          left: xCoords.value[index] -
              sizes.value[index] / 3 +
              context.width * 0.1,
          top: yCoords.value[index] +
              (onlyBottomBubbles ? sizes.value[index] / 3 : -200),
          child: Blob.animatedRandom(
            size: sizes.value[index].toDouble(),
            // edgesCount: 6,
            minGrowth: 4,
            loop: true,
            styles: BlobStyles(
              color: bubbleColor ??
                  context.cs.primary.withOpacity(opacities.value[index]),
            ),
            duration: durations.value[index],
          )
              .animate()
              .then(delay: delayInMilliseconds.milliseconds)
              .slide(
                begin: const Offset(0, 0.6),
                duration: slideInDurationInMilliseconds.milliseconds,
                curve: Curves.easeOutExpo,
              )
              .fadeIn(duration: fadeInDurationInMilliseconds.milliseconds)
              .blur(
                begin: const Offset(2, 2),
                end: Offset(blurs.value[index], blurs.value[index]),
                duration: 2.seconds,
              ),
        ),
      ),
    );

    return Stack(
      children: [
        if (backgroundColor != null)
          Container(
            color: backgroundColor,
          ),
        ...blobs.value
      ],
    );
  }
}
