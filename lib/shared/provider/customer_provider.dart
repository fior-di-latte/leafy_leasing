// Project imports:
import 'package:leafy_leasing/shared/base.dart';

part 'customer_provider.g.dart';

typedef CustomerId = String;

@riverpod
class CustomerState extends _$CustomerState
    with AsyncProviderMixin<Customer, CustomerId> {
  @override
  FutureOr<Customer> build(CustomerId id) async {
    repoCache = await ref.watch(customerRepositoryCacheProvider.future);
    return buildFromStream(id);
  }
}

sealed class CustomerRepository implements Repository<Customer, CustomerId> {
  factory CustomerRepository.get() => switch (dotenv.backend) {
        (Backend.hive) => HiveCustomerRepository(),
        (Backend.supabase) => SupabaseCustomerRepository(),
      };

  Future<void> removeCustomer();
}

@riverpod
Future<(CustomerRepository, Cache<Customer>)> customerRepositoryCache(
    CustomerRepositoryCacheRef ref) async {
  final cache = await ref.cache(fromJson: Customer.fromJson);
  return (CustomerRepository.get(), cache);
}

final class HiveCustomerRepository
    with HiveSingletonMixin
    implements CustomerRepository {
  @override
  Future<void> removeCustomer() {
    // TODO: implement removeCustomer
    throw UnimplementedError();
  }

  @override
  Future<Customer> get(CustomerId id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Stream<Customer> listenable(CustomerId id) {
    // TODO: implement listenable
    throw UnimplementedError();
  }

  @override
  Future<Customer> put(Customer item, {required CustomerId id}) {
    // TODO: implement put
    throw UnimplementedError();
  }
}

final class SupabaseCustomerRepository
    with SupabaseSingletonMixin
    implements CustomerRepository {
  @override
  Future<void> removeCustomer() {
    // TODO: implement removeCustomer
    throw UnimplementedError();
  }

  @override
  Future<Customer> get(CustomerId id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Customer> put(Customer item, {CustomerId? id}) {
    // TODO: implement put
    throw UnimplementedError();
  }

  @override
  Stream<Customer> listenable(CustomerId id) {
    // TODO: implement listenable
    throw UnimplementedError();
  }
}
