import 'package:easy_debounce/easy_throttle.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/provider/internet_connection_provider.dart';
import 'package:overlay_support/overlay_support.dart';

const internetOverlayKey = Key('internetOverlay');

class AllNotificationListener extends ConsumerWidget {
  const AllNotificationListener({required this.child, super.key});

  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen(
        internetConnectionProvider,
        (before, status) {
          _maybeShowSyncNotification(ref, before, status);
          _maybeShowInternetOverlay(status, context);
        },
      )
      ..listen(
        notificationProvider,
        (_, snackbarBuilder) => EasyThrottle.throttle(
          snackbarBuilder.type.toString(),
          snackbarBuilder.type.throttleDuration,
          () => snackbarBuilder.builder(context),
        ),
      );
    return child;
  }

  static void _maybeShowSyncNotification(
    WidgetRef ref,
    AsyncValue<InternetConnectionStatus>? before,
    AsyncValue<InternetConnectionStatus> status,
  ) {
    if (before?.value == InternetConnectionStatus.disconnected &&
        status.value == InternetConnectionStatus.connected) {
      ref.notification = SnackbarBuilder(
        (context) {
          showTopInfo(
            context,
            duration: 5.seconds,
            textColor: context.cs.error,
            showProgressIndicator: true,
            leading: const Icon(Icons.refresh_outlined)
                .animate()
                .crossfade(
                  duration: 300.milliseconds,
                  delay: 3.seconds,
                  builder: (_) => Icon(
                    Icons.check_circle_outline_outlined,
                    color: context.cs.primary,
                  ),
                )
                .scaleXY(
                  duration: 800.milliseconds,
                  curve: Curves.easeIn,
                  begin: 1,
                  end: 1.3,
                ),
            title: context.lc.syncWithServerTitle,
            description: context.lc.syncWithServerMessage,
          );
        },
        type: SnackbarType.success,
      );
    }
  }

  static void _maybeShowInternetOverlay(
    AsyncValue<InternetConnectionStatus> status,
    BuildContext context,
  ) {
    status.whenData(
      (status) => showOverlay(
        key: internetOverlayKey,
        duration: Duration.zero,
        (_, t) => status == InternetConnectionStatus.disconnected
            ? Theme(
                data: Theme.of(context),
                child: Opacity(
                  opacity: t,
                  child: const NoNetworkLogo(),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

class NoNetworkLogo extends StatelessWidget {
  const NoNetworkLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: const Alignment(.8, -0.98),
        child: Transform.scale(
          scale: .7,
          child: ClipRRect(
            borderRadius: kBorderRadius,
            child: Container(
              color: context.thm.hintColor,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: const Icon(
                Icons.wifi_off,
                color: Colors.white,
              ),
            ),
          ),
        )
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .scaleXY(
              begin: 0.9,
              end: 1.2,
              duration: 1600.milliseconds,
              curve: Curves.easeOut,
            )
            .fade(begin: .6, end: 1),
      ),
    );
  }
}
