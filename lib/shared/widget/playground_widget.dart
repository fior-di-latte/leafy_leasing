// Project imports:
import 'package:animated_glitch/animated_glitch.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:leafy_leasing/feature/home/provider/metas_provider.dart';
import 'package:leafy_leasing/shared/base.dart';

/// this is a playground widget to rapidly test stuff
/// and is used in [HomeView].
class PlaygroundWidget extends HookConsumerWidget {
  const PlaygroundWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //create a path that is a circle
    final path1 = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset.zero,
          radius: 100,
        ),
      );
    final path2 = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset.zero,
          radius: 10,
        ),
      );
    // concat both paths
    final path = Path.combine(PathOperation.union, path1, path2);
    final controller = useScrollController();
    final alignment = useState(const Alignment(0, 0));
    final _controller = useMemoized(() => AnimatedGlitchController(
        frequency: const Duration(milliseconds: 200),
        level: 1.2,
        distortionShift: const DistortionShift(count: 3)));
    final l = ListView.builder(
        shrinkWrap: true,
        controller: controller,
        // build Text (Hello 'i') for i in 0,..100
        itemBuilder: (context, i) => Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CircleAvatar(
                  radius: 100,
                  foregroundImage: AssetImage(Assets.imageLogo),
                ))),
        itemCount: 100);

    return Stack(
      children: [
        Container(color: Colors.red),
        AnimatedAlign(
          duration: 300.milliseconds,
          curve: Curves.easeInBack,
          alignment: alignment.value,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: kBorderRadius,
              border: Border.all(color: Colors.green, width: 5),
            ),
            child: ClipRRect(
              borderRadius: kBorderRadius,
              child: const _Glitched(
                key: Key('network'),
                image: NetworkImage(
                  'https://imagedelivery.net/9sCnq8t6WEGNay0RAQNdvQ/UUID-cl9g6xtht2498q7lq51hp2c8q/public',
                ),
              ),
            ),
          ).animate(key: ValueKey(alignment.value)).flipV(
              begin: 1.8,
              end: 2,
              duration: 700.milliseconds,
              curve: Curves.easeOutBack),
        ),
        FloatingActionButton(onPressed: () {
          alignment.value =
              Alignment(rnd.getDouble(-1, 1), rnd.getDouble(-1, 1));
        }),
        Align(alignment: Alignment.bottomCenter, child: const SomeText())
      ],
    );
  }
}

class _Glitched extends StatefulWidget {
  final ImageProvider image;

  const _Glitched({
    required this.image,
    super.key,
  });

  @override
  State<_Glitched> createState() => _GlitchedState();
}

class _GlitchedState extends State<_Glitched> {
  final _controller = AnimatedGlitchController(
    level: 2,
    frequency: const Duration(milliseconds: 200),
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedGlitch(
      controller: _controller,
      child: Image(
        image: widget.image,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}

class SomeText extends StatelessWidget {
  const SomeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return Material(
      child: SizedBox(
        width: 250.0,
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText('Discipline is the best tool',
                speed: 70.milliseconds),
            TypewriterAnimatedText('Design first, then code',
                speed: 70.milliseconds),
            TypewriterAnimatedText('Do not patch bugs out, rewrite them',
                speed: 70.milliseconds),
            TypewriterAnimatedText('Do not test bugs out, design them out',
                speed: 70.milliseconds),
          ],
          onTap: () {
            print("Tap Event");
          },
          pause: 3.seconds,
        ),
      ),
    );
  }
}
