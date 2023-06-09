import 'package:leafy_leasing/shared/base.dart';

part 'customer_provider.g.dart';

typedef CustomerId = String;

@riverpod
class CustomerState extends _$CustomerState
    with AsyncCachedProviderMixin<Customer, CustomerId> {
  @override
  FutureOr<Customer> build(CustomerId id) {
    ref.watch(customerRepositoryCacheProvider);
    return buildFromRepository(
      customerRepositoryCacheProvider,
      id: id,
      strategy: FetchingStrategy.single,
    );
  }
}

sealed class CustomerRepository implements Repository<Customer, CustomerId> {
  factory CustomerRepository.get() => switch (dotenv.backend) {
        (Backend.hive) => HiveCustomerRepository(),
        (Backend.supabase) => throw UnimplementedError(),
      };
}

@riverpod
Future<(CustomerRepository, Cache<Customer>)> customerRepositoryCache(
  CustomerRepositoryCacheRef ref,
) async {
  final cache = await ref.cache(fromJson: Customer.fromJson);
  return (CustomerRepository.get(), cache);
}

final class HiveCustomerRepository
    with HiveSingletonMixin<Customer, CustomerId>
    implements CustomerRepository {
  @override
  late final box = client.box<Customer>(hiveCustomers);
}
