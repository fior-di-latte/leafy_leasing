import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/data_services/hive.dart';

final customerProvider = StateNotifierProvider.autoDispose
    .family<CustomerNotifier, AsyncValue<Customer>, String>(
  name: 'CustomerProvider',
  (ref, id) => CustomerNotifier(ref, id: id),
);

abstract class CustomerNotifier implements StateNotifier<AsyncValue<Customer>> {
  factory CustomerNotifier(AutoDisposeRef ref, {required String id}) =>
      dotenv.get('USE_HIVE_MOCK_BACKEND') == 'true'
          ? CustomerHiveNotifier(ref, id: id)
          : CustomerHiveNotifier(ref, id: id);
}

// This class extends a state notifier for a customer object stored in a Hive database, with a required ID parameter.
class CustomerHiveNotifier extends HiveAsyncStreamNotifier<Customer>
    implements CustomerNotifier {
  CustomerHiveNotifier(super.ref, {required String id})
      : super(boxName: hiveCustomers, key: id);
}
