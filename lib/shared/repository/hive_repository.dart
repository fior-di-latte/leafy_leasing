import 'package:hive_flutter/hive_flutter.dart';
import 'package:leafy_leasing/shared/base.dart';

import 'package:leafy_leasing/shared/repository/abstract_repository.dart';

class HiveRepositoryImpl<T> implements HiveRepository<T> {
  HiveRepositoryImpl(this.boxName, {required this.key})
      : _box = Hive.box<T>(boxName);

  @override
  final String boxName;

  @override
  final String key;
  final Box<T> _box;

  @override
  Future<void> delete() async {
    await Future.delayed(kMockNetworkLag, () => _box.delete(key));
  }

  @override
  T? syncGet() {
    return _box.get(key);
  }

  @override
  Future<T> put(T item) async {
    await Future.delayed(kMockNetworkLag, () => _box.put(key, item));
    return item;
  }

  @override
  Stream<BoxEvent> keyObservable() {
    return _box.watch(key: key);
  }

  @override
  Future<T?> get() => Future.delayed(kMockNetworkLag, syncGet);
}
