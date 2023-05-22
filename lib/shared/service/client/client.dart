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

abstract class ModelClient<T> {
  Future<T> get(String id);
}

sealed class CustomerClient extends ModelClient<Customer> {
  CustomerClient();

  factory CustomerClient.get() {
    return switch (dotenv.backend) {
      (Backend.hive) => HiveCustomerClient(boxName: hiveCustomers),
      (Backend.supabase) => SupabaseCustomerClient(),
    };
  }

  Future<void> removeCustomer();
}

@riverpod
CustomerClient customerClient(CustomerClientRef ref) => CustomerClient.get();

final class HiveCustomerClient extends StandardHiveAsyncModelClient<Customer>
    implements CustomerClient {
  HiveCustomerClient({required String boxName}) : super(boxName: boxName);
  @override
  Future<void> removeCustomer() {
    // TODO: implement removeCustomer
    throw UnimplementedError();
  }
}

final class SupabaseCustomerClient extends ModelClient<Customer>
    with SupabaseSingletonMixin
    implements CustomerClient {
  @override
  Future<void> removeCustomer() {
    // TODO: implement removeCustomer
    throw UnimplementedError();
  }

  @override
  Future<Customer> get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }
}
