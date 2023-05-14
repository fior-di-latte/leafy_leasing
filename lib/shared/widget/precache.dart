// Project imports:
import 'package:leafy_leasing/shared/base.dart';

class PrecacheProvider extends ConsumerWidget {
  const PrecacheProvider({
    required this.child,
    required this.provider,
    super.key,
  });
  final Widget child;
  final ProviderListenable<AsyncValue<Object?>> provider;
  @override
  Widget build(BuildContext context, WidgetRef ref) => Stack(
        children: [
          Consumer(
            builder: (_, ref, __) {
              ref.watch(provider);
              return const SizedBox.shrink();
            },
          ),
          child
        ],
      );
}

class WarmUp extends HookConsumerWidget {
  const WarmUp({this.providers, required this.child, super.key});

  final List<ProviderListenable<AsyncValue<Object?>>>? providers;
  final Widget child;
  static const _splashLogoSize = 80.0;
  static final _animationScaleUpDuration =
      (.5 * kSplashMinWaitingTime.inMilliseconds).milliseconds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (providers == null) {
      return child;
    }

    final splashHasTimedOut = useTimeOutFuture(kSplashMaxWaitingTime);
    final splashAllowedToHide = useTimeOutFuture(kSplashMinWaitingTime);

    final states = providers!.map((p) => ref.watch(p));

    final loadingComplete = states.every((state) => state is AsyncData);
    final showSplash =
        (!loadingComplete && !splashHasTimedOut) || !splashAllowedToHide;

    _useLogLoadingTimes(showSplash, splashHasTimedOut, splashAllowedToHide);
    _logErrors(states);

    return Directionality(
      // needed because this is before MaterialApp in the widget tree
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          child,
          AnimatedSwitcher(
            duration: 300.milliseconds,
            child: showSplash
                ? ColoredBox(
                    color: kAppBarColor,
                    child: Center(
                      child: ClipOval(
                        child: Container(
                          color: Color.lerp(kSeedColor, kAppBarColor, .5),
                          padding: const EdgeInsets.all(3),
                          child: ClipOval(
                            child: Image.asset(
                              Assets.imageLogo,
                              fit: BoxFit.cover,
                              width: _splashLogoSize,
                              height: _splashLogoSize,
                            ),
                          ),
                        ),
                      ).animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(
                            end: 1.5,
                            duration: _animationScaleUpDuration,
                            curve: Curves.easeOut,
                          ),
                    ),
                  )
                : SizedBox.shrink(
                    key: UniqueKey(),
                  ),
          ),
        ],
      ),
    );
  }

  void _useLogLoadingTimes(
    bool showSplash,
    bool splashHasTimedOut,
    bool splashAllowedToHide,
  ) {
    useValueChanged(showSplash, (_, __) {
      if (splashHasTimedOut) {
        logger.w('Splash: Timeout, still loading');
      } else if (splashAllowedToHide) {
        logger
            .i('Splash: Loading completed even before animation was finished');
      } else {
        logger.w('Splash: Loading successful:');
      }

      return true;
    });
  }

  void _logErrors(Iterable<AsyncValue<Object?>> states) {
    for (final state in states) {
      if (state is AsyncError) {
        logger.e('Error while warming up: ${state.error}');
      }
    }
  }
}
