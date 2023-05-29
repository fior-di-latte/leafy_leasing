// Project imports:
import 'package:leafy_leasing/shared/base.dart';

enum SnackbarType {
  info(Duration.zero),
  error(Duration(seconds: 2)),
  success(Duration(seconds: 2));

  const SnackbarType(this.throttleDuration);
  final Duration throttleDuration;
}

class SnackbarBuilder {
  SnackbarBuilder(this.builder, {required this.type});

  factory SnackbarBuilder.init() =>
      SnackbarBuilder((_) {}, type: SnackbarType.info);

  factory SnackbarBuilder.error([String? message]) {
    return SnackbarBuilder(_defaultErrorCallback, type: SnackbarType.error);
  }

  final void Function(BuildContext context) builder;
  final SnackbarType type;

  static void _defaultErrorCallback(BuildContext context,
          {String? title, String? message}) =>
      showTopInfo(context,
          textColor: context.cs.error,
          leading: Icon(
            Icons.error_outline_outlined,
            color: context.cs.error,
          ),
          title: title ?? context.lc.somethingWentWrong,
          description: message);
}

final notificationProvider = StateProvider<SnackbarBuilder>(
  name: 'NotificationProvider',
  (ref) => SnackbarBuilder.init(),
);

extension AddNotification on Ref {
  set notification(SnackbarBuilder builder) {
    read(notificationProvider.notifier).state = builder;
  }
}
