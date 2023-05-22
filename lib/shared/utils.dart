// Dart imports:
import 'dart:async';

// Project imports:
import 'package:leafy_leasing/l10n/l10n.dart';
import 'package:leafy_leasing/shared/base.dart';

extension AddConvenience on BuildContext {
  AppLocalizations get lc => AppLocalizations.of(this);
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  ThemeData get thm => Theme.of(this);
  ColorScheme get cs => Theme.of(this).colorScheme;
  TextTheme get tt => Theme.of(this).textTheme;
}

extension DisposeExtension<T> on AutoDisposeRef<T> {
  void disposeDelay(Duration duration) {
    final link = keepAlive();
    Timer? timer;

    onCancel(() {
      timer?.cancel();
      timer = Timer(duration, link.close);
    });

    onDispose(() {
      timer?.cancel();
    });

    onResume(() {
      timer?.cancel();
    });
  }

  void cacheFor(Duration duration) {
    final link = keepAlive();
    final timer = Timer(duration, link.close);

    onDispose(timer.cancel);
  }
}

extension AddCustomLoadingErrorWidgets<T> on AsyncValue<T> {
  Widget whenFine(
    Widget Function(T dataInstance) data, {
    String? loadingInfo,
    bool hasShimmer = false,
    bool skipLoadingOnRefresh = true,
    bool skipLoadingOnReload = true,
    bool skipError = false,
    bool fadeInData = false,
  }) {
    final placeholder = hasShimmer
        ? Container(color: Colors.grey)
            .animate(onInit: (c) => c.repeat())
            .shimmer()
        : const SizedBox.shrink();
    return maybeWhen(
      skipLoadingOnRefresh: skipLoadingOnRefresh,
      skipLoadingOnReload: skipLoadingOnReload,
      skipError: skipError,
      orElse: () => placeholder,
      data: (T dataInstance) => AnimatedSwitcher(
        key: ValueKey(dataInstance),
        duration: 300.milliseconds,
        child: fadeInData
            ? data(dataInstance).animate().fadeIn()
            : data(dataInstance),
      ),
    );
  }
}

// generate a color from a string in a deterministic manner
Color stringToColor(String str, BuildContext context) {
  final hash = str.hashCode;
  final r = (hash & 0xFF0000) >> 16;
  final g = (hash & 0x00FF00) >> 8;
  final b = hash & 0x0000FF;
  return Color.lerp(Color.fromARGB(255, r, g, b), context.cs.primary, .5)!
      .withOpacity(.5);
}

enum Backend { hive, supabase }

extension Lol on DotEnv {
  Backend get backend {
    final useHive = bool.parse(dotenv.get('USE_HIVE_MOCK_BACKEND'));
    final useSupabase = bool.parse(dotenv.get('USE_SUPABASE_BACKEND'));

    final bothFalse = !useHive && !useSupabase;
    final bothTrue = useHive && useSupabase;
    assert(!(bothFalse || bothTrue), 'Only use one backend solution!');

    return useHive ? Backend.hive : Backend.supabase;
  }
}
