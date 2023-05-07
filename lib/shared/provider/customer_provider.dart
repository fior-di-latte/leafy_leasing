// Project imports:
import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/data_services/hive.dart';
import 'package:leafy_leasing/shared/repository/abstract_repository.dart';
import 'package:leafy_leasing/shared/repository/hive_repository.dart';

part 'customer_provider.g.dart';

typedef CustomerRepository = AsyncRepository<Customer>;

@riverpod
CustomerRepository customerRepository(
  Ref ref, {
  required String key,
}) {
  return dotenv.get('USE_HIVE_MOCK_BACKEND') == 'true'
      ? HiveAsyncRepositoryImpl<Customer>(hiveCustomers, key: key)
      : HiveAsyncRepositoryImpl<Customer>(hiveCustomers, key: key);
}

@riverpod
class CustomerState extends _$CustomerState
    with AsyncRepositoryMixin<Customer> {
  @override
  FutureOr<Customer> build(String id) async {
    repository = ref.watch(customerRepositoryProvider(key: id));

    return buildFromStream();
  }
}
