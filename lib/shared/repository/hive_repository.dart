import 'package:hive_flutter/hive_flutter.dart';
import 'package:leafy_leasing/shared/base.dart';

import 'abstract_repository.dart';

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
    await _box.delete(key);
  }

  @override
  T? syncGet() {
    return _box.get(key);
  }

  @override
  Future<void> put(T item) async {
    await _box.put(key, item);
  }

  @override
  Stream<BoxEvent> keyObservable() {
    return _box.watch(key: key);
  }

  @override
  Future<T?> get() => Future.delayed(kMockNetworkLag, () => syncGet());
}
