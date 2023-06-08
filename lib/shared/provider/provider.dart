import 'package:leafy_leasing/shared/base.dart';

export 'appointment_provider.dart';
export 'cached_provider_mixin.dart';
export 'customer_provider.dart';
export 'notification_provider.dart';
export 'provider_mixin.dart';
export 'settings_provider.dart';

enum FetchingStrategy { single, polling, stream }

typedef ErrorUiCallback = void Function(BuildContext context);

class NoCacheFallbackException implements Exception {
  NoCacheFallbackException(this.type, this.id);
  final Type type;
  final String id;
  @override
  String toString() => 'No Internet (according to provider) and'
      ' no cached value for $type $id found.';
}
