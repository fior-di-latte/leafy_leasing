part of 'package:leafy_leasing/shared/service/client/client.dart';

base mixin HiveClientMixin on ModelClient {
  final client = HiveInstance().instance;
}

final class HiveInstance extends Client {
  factory HiveInstance() => _singleton;
  HiveInstance._();
  final instance = Hive; // client singleton
  static final HiveInstance _singleton = HiveInstance._();

  @override
  Future<void> _initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }
}
