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

  final void Function(BuildContext context) builder;
  final SnackbarType type;
}

final notificationProvider = StateProvider<SnackbarBuilder>(
  name: 'NotificationProvider',
  (ref) => SnackbarBuilder.init(),
);
