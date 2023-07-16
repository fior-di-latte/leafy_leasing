// Dart imports:
import 'dart:async';
import 'dart:io';

// Project imports:
import 'package:leafy_leasing/shared/service/stash_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:leafy_leasing/l10n/l10n.dart';
import 'package:leafy_leasing/shared/base.dart';
import 'package:isar/isar.dart';

extension AddConvenience on BuildContext {
  AppLocalizations get lc => AppLocalizations.of(this);
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  ThemeData get thm => Theme.of(this);
  ColorScheme get cs => Theme.of(this).colorScheme;
  TextTheme get tt => Theme.of(this).textTheme;
  Insets get insets => Theme.of(this).extension<Insets>()!;
  double get scaleFactor => scaleFromMediaQuery(this);
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;
  // check if platform is mobile
  bool get isWideLandscape =>
      MediaQuery.of(this).size.aspectRatio > 1.25 &&
      // wide landscape should only be available on desktop or web
      kIsWeb;
}

extension DisposeExtension<T> on AutoDisposeRef<T> {
  Future<Cache<R>> cache<R>({
    required R Function(Map<String, dynamic>) fromJson,
    String? name,
  }) async {
    final store = await watch(cacheStoreProvider.future);
    return store.createLoggedCache(fromJson: fromJson, name: name);
  }

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
    bool crossfadeDataAndOverrideKeys = false,
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
      data: (T dataInstance) {
        var child = data(dataInstance);

        if (crossfadeDataAndOverrideKeys) {
          child = AnimatedSwitcher(
            key: ValueKey(dataInstance),
            duration: 300.milliseconds,
            child: child,
          );
        }

        return child;
      },
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

extension AddBackend on DotEnv {
  Backend get backend {
    final useHive = bool.parse(dotenv.get('USE_HIVE_MOCK_BACKEND'));
    final useSupabase = bool.parse(dotenv.get('USE_SUPABASE_BACKEND'));

    final bothFalse = !useHive && !useSupabase;
    final bothTrue = useHive && useSupabase;
    assert(!(bothFalse || bothTrue), 'Only use one backend solution!');

    return useHive ? Backend.hive : Backend.supabase;
  }
}

Future<void> throwTimeOutErrorWhenManualInternetCheckFails() async {
  if (kIsWeb) return;
  final connectionStatus = await InternetConnectionChecker().connectionStatus;
  if (connectionStatus == InternetConnectionStatus.disconnected) {
    throw TimeoutException('Manual check: No internet!');
  }
}
