part of 'package:leafy_leasing/shared/service/client/client.dart';

//
// class StandardHiveAsyncModelClient<T> extends Repository<T>
//     with HiveSingletonMixin<T> {
//   StandardHiveAsyncModelClient({required this.boxName});
//
//   final String boxName;
//
//   @override
//   Future<T> get(String key) async {
//     return Future.delayed(
//         kMockNetworkLag, () => client.box<T>(boxName).get(key)!);
//   }
//
//   @override
//   Future<T> put(T item, {String? id}) => Future.delayed(kMockNetworkLag, () {
//         client.box<T>(boxName).put(id, item);
//         return item;
//       });
//
//   Stream<T> listenable(String key) =>
//       client.box<T>(boxName).watch(key: key).map((_) => syncGet(key)!);
//
//   T syncGet(String key) {
//     return client.box<T>(boxName).get(key)!;
//   }
// }
//
mixin HiveSingletonMixin {
  final client = HiveInstance().instance;
}

class HiveInstance extends Client {
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
