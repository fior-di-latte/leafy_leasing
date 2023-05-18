import 'package:leafy_leasing/shared/base.dart';

part 'client.g.dart';

sealed class Client {
  Client(); // needed for inheritance
  factory Client.create() => switch (dotenv.backend) {
        (Backend.hive) => HiveInstance(),
        (Backend.supabase) => SupabaseInstance(),
      };

  int get myGeneralClientFunction => 5;
  static Future<void> initialize() => Client.create()._initialize();
  Future<void> _initialize();
}

abstract base class ModelClient {}

base mixin SupabaseClientMixin on ModelClient {
  final client = SupabaseInstance();
}

class SupabaseInstance extends Client {
  factory SupabaseInstance() => _instance;
  SupabaseInstance._();
  final client = 42; // client singleton
  static final SupabaseInstance _instance = SupabaseInstance._();

  @override
  Future<void> _initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }
// singleton instance
}

// the same mixin and singleton for Hive
base mixin HiveClientMixin on ModelClient {
  final client = HiveInstance();
}

final class HiveInstance extends Client {
  factory HiveInstance() => _instance;
  HiveInstance._();
  final client = 42; // client singleton
  static final HiveInstance _instance = HiveInstance._();

  @override
  Future<void> _initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }
}

sealed class CustomerClient extends ModelClient {
  Future<void> removeCustomer();
}

@riverpod
CustomerClient customerClient(CustomerClientRef ref) =>
    switch (dotenv.backend) {
      (Backend.hive) => HiveCustomerClient(),
      (Backend.supabase) => SupabaseCustomerClient(),
    };

final class HiveCustomerClient extends CustomerClient with HiveClientMixin {
  @override
  Future<void> removeCustomer() {
    // TODO: implement removeCustomer
    throw UnimplementedError();
  }
}

final class SupabaseCustomerClient extends CustomerClient
    with SupabaseClientMixin {
  @override
  Future<void> removeCustomer() {
    // TODO: implement removeCustomer
    throw UnimplementedError();
  }
}
