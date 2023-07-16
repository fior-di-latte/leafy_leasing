import 'dart:async';

import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/service/stash_cache.dart';
import 'package:visibility_detector/visibility_detector.dart';

part 'shimmer_conditional.g.dart';

@riverpod
Future<Cache<String>> _shimmerCache(_ShimmerCacheRef ref) async {
  final store = await ref.watch(cacheStoreProvider.future);
  return store.cache<String>(name: 'shimmer', maxEntries: 1000);
}

@riverpod
Future<bool> shimmeredBefore(ShimmeredBeforeRef ref, String key) async {
  final cache = await ref.watch(_shimmerCacheProvider.future);
  final didShimmer = await cache.get(key) != null;

  // save the impending shimmer
  if (!didShimmer) {
    logger.i('Shimmering $key saved');
    unawaited(cache.put(key, '1'));
  }

  return didShimmer;
}

typedef TriggeredAnimation = Animate Function(
  Widget child, {
  required bool trigger,
});

extension AddBrandNew on Widget {
  Widget newShimmerFlip(
    String tag, {
    bool hideBeforeShimmer = true,
    Duration? delay,
  }) =>
      WhenNew(
        hideBeforeShimmer: hideBeforeShimmer,
        tag: tag,
        child: this,
        triggeredAnimation: (child, {required bool trigger}) => child
            .animate(
              autoPlay: false,
              target: trigger ? 1 : 0,
            )
            .shimmer(duration: 950.milliseconds, delay: delay)
            .flipV(
              duration: 400.milliseconds,
              curve: Curves.easeOut,
              begin: 1.6,
              end: 2,
            )
            .fadeIn(),
      );

  Widget newShimmerBounce(
    String tag, {
    bool hideBeforeShimmer = true,
    Duration? delay,
  }) =>
      WhenNew(
        hideBeforeShimmer: hideBeforeShimmer,
        tag: tag,
        child: this,
        triggeredAnimation: (child, {required bool trigger}) => child
            .animate(autoPlay: false, target: trigger ? 1 : 0)
            .fadeIn(duration: 450.milliseconds, delay: delay)
            .scaleXY(begin: 1, end: 1.25)
            .then()
            .scaleXY(begin: 1, end: .8, duration: 450.milliseconds)
            .shimmer(curve: Curves.easeOut, duration: 900.milliseconds),
      );

  Widget newShimmer(
    String tag, {
    bool hideBeforeShimmer = false,
    Duration? delay,
  }) =>
      WhenNew(
        hideBeforeShimmer: hideBeforeShimmer,
        tag: tag,
        child: this,
        triggeredAnimation: (child, {required bool trigger}) =>
            child.animate(autoPlay: false, target: trigger ? 1 : 0).shimmer(
                  curve: Curves.easeOut,
                  duration: 900.milliseconds,
                  delay: delay,
                ),
      );
}

class WhenNew extends HookConsumerWidget {
  const WhenNew({
    required this.child,
    this.hideBeforeShimmer = false,
    required this.triggeredAnimation,
    required this.tag,
    super.key,
  });

  final TriggeredAnimation triggeredAnimation;
  final Widget child;
  final bool hideBeforeShimmer;
  final String tag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doShimmer = useState(false);
    return ref.watch(shimmeredBeforeProvider(tag)).whenFine((didShimmer) {
      final widget = switch ((doShimmer.value, hideBeforeShimmer, didShimmer)) {
        (true, _, _) => triggeredAnimation(child, trigger: doShimmer.value),
        (false, true, false) => const SizedBox.expand(),
        _ => child,
      };

      return VisibilityDetector(
        onVisibilityChanged: (info) =>
            _shimmerChecker(info, doShimmer, didShimmer),
        key: Key(tag),
        child: widget,
      );
    });
  }

  void _shimmerChecker(
    VisibilityInfo info,
    ValueNotifier<bool> doShimmer,
    bool didShimmer,
  ) {
    if (info.visibleFraction > .2 && !doShimmer.value && !didShimmer) {
      doShimmer.value = true;
    }
  }
}
