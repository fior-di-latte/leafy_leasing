import 'package:hive_flutter/hive_flutter.dart';
import 'package:leafy_leasing/shared/base.dart';

part 'hive_instance.dart';
part 'supabase_instance.dart';
part 'client.g.dart';

sealed class Client {
  Client(); // needed for inheritance
  factory Client._create() => switch (dotenv.backend) {
        (Backend.hive) => HiveInstance(),
        (Backend.supabase) => SupabaseInstance(),
      };

  int get myGeneralClientFunction => 5;
  static Future<void> initialize() => Client._create()._initialize();
  Future<void> _initialize();
}

abstract base class ModelClient {}

sealed class CustomerClient extends ModelClient {
  CustomerClient();

  factory CustomerClient.get() {
    return switch (dotenv.backend) {
      (Backend.hive) => HiveCustomerClient(),
      (Backend.supabase) => SupabaseCustomerClient(),
    };
  }

  Future<void> removeCustomer();
}

@riverpod
CustomerClient customerClient(CustomerClientRef ref) => CustomerClient.get();

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
