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
mixin HiveSingletonMixin<T, ID> {
  final client = HiveInstance().instance;
  abstract final Box<T> box;

  Stream<T> listenable(ID id) {
    assert(ID == String, 'Hive only supports String keys');
    final key = id as String;
    return box.watch(key: key).map((_) => box.get(key)!);
  }

  Future<T> get(ID id) async {
    assert(ID == String, 'Hive only supports String keys');
    await throwTimeOutErrorWhenManualInternetCheckFails();
    final key = id as String;
    return Future.delayed(kMockNetworkLag, () {
      final val = box.get(key);
      if (val == null) {
        throw Exception('No value found for key: $key');
      }
      return val;
    });
  }

  Future<T> put(T item, {required ID id}) async {
    assert(ID == String, 'Hive only supports String keys');
    await throwTimeOutErrorWhenManualInternetCheckFails();
    final key = id as String;
    return Future.delayed(kMockNetworkLag, () {
      box.put(key, item);
      return item;
    });
  }
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
