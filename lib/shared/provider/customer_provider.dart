// Project imports:
import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/repository/abstract_repository.dart';
import 'package:leafy_leasing/shared/repository/hive_repository.dart';

part 'customer_provider.g.dart';

typedef CustomerRepository = AsyncRepository<Customer>;

@riverpod
Future<Cache<Customer>> customerCache(CustomerCacheRef ref) async {
  final store = await ref.watch(isarCacheStoreProvider.future);
  return store.createLoggedCache(fromJson: Customer.fromJson);
}

@riverpod
Future<CustomerRepository> customerRepository(
  CustomerRepositoryRef ref, {
  required String key,
}) async {
  final cache = await ref.watch(customerCacheProvider.future);
  return dotenv.get('USE_HIVE_MOCK_BACKEND') == 'true'
      ? HiveAsyncCachedRepositoryImpl<Customer>(
          hiveCustomers,
          key: key,
          cache: cache,
        )
      : HiveAsyncCachedRepositoryImpl<Customer>(
          hiveCustomers,
          key: key,
          cache: cache,
        );
}

@riverpod
class CustomerState extends _$CustomerState with AsyncProviderMixin<Customer> {
  @override
  FutureOr<Customer> build(String id) async {
    repository = await ref.watch(customerRepositoryProvider(key: id).future);

    return buildFromStream();
  }
}
