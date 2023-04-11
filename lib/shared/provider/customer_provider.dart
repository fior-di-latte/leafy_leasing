import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/data_services/hive.dart';

final customerProvider = StateNotifierProvider.autoDispose
    .family<CustomerNotifier, AsyncValue<Customer>, String>(
        name: 'CustomerProvider', (ref, id) => CustomerNotifier(ref, id: id));

class CustomerNotifier extends HiveAsyncStateNotifier<Customer> {
  CustomerNotifier(AutoDisposeRef ref, {required String id})
      : super(ref, boxName: hiveCustomers, key: id);
}
