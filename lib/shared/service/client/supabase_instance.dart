part of 'package:leafy_leasing/shared/service/client/client.dart';

base mixin SupabaseSingletonMixin<T> on ModelClient<T> {
  final client = SupabaseInstance().instance;
}

class SupabaseInstance extends Client {
  factory SupabaseInstance() => _singleton;
  SupabaseInstance._();
  final instance = 42; // client singleton
  static final SupabaseInstance _singleton = SupabaseInstance._();

  @override
  Future<void> _initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }
// singleton instance
}
