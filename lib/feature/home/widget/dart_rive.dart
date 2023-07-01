import 'package:leafy_leasing/shared/base.dart';
import 'package:rive/rive.dart';

class FlutterRiveAnimation extends HookConsumerWidget {
  const FlutterRiveAnimation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SMITrigger? lookUp;
    SMIBool? isDancing;

    void _onRiveInit(Artboard artboard) {
      final controller = StateMachineController.fromArtboard(artboard, 'birb');
      artboard.addController(controller!);
      isDancing = controller.findSMI('dance');
      lookUp = controller.findSMI('look up');
      artboard.forEachComponent((child) {
        if (child is Shape) {
          // filter more like && child.name == 'Button1'
          final Shape shape = child;
          shape.fills.first.paint.color = Colors.red;
        }
      });
    }

    final animation = useAnimationController(duration: 2.seconds)
      ..repeat(reverse: true);

    final tween = ColorTween(
      begin: context.thm.primaryColor,
      end: context.thm.secondaryHeaderColor,
    ).animate(animation);
    void doLookUp() => lookUp?.fire();
    return ListenableBuilder(
      listenable: tween,
      builder: (context, widget) => ColorFiltered(
        colorFilter: ColorFilter.mode(tween.value!, BlendMode.modulate),
        child: SizedBox(
          height: 300,
          width: 300,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: doLookUp,
              child: RiveAnimation.asset(
                Assets.assetsFlutterRive,
                onInit: _onRiveInit,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
