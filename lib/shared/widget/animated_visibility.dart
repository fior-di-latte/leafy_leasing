import 'package:leafy_leasing/shared/base.dart';

class AnimatedVisibility extends StatelessWidget {
  AnimatedVisibility({
    required this.child,
    required this.visible,
    Duration? duration,
    Duration? reverseDuration,
    Key? key,
  })  : _duration = duration ?? 300.milliseconds,
        _reverseDuration = reverseDuration ?? duration ?? 300.milliseconds,
        super(key: key);
  final Duration _duration;
  final Duration _reverseDuration;
  final Widget child;
  final bool visible;
  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
        duration: _duration,
        reverseDuration: _reverseDuration,
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeOut,
        child: visible ? child : const SizedBox.shrink(),
      );
}
