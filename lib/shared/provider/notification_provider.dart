// Project imports:
import 'package:leafy_leasing/shared/base.dart';

extension AsyncValueUI on AsyncValue<Object> {
  // show a snackbar on error only
  void showSnackBarOnError(BuildContext context) => whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
      );
}

typedef SnackbarBuilder = void Function(BuildContext context);

final notificationProvider = StateProvider<SnackbarBuilder>(
  name: 'NotificationProvider',
  (ref) => (context) {},
);
