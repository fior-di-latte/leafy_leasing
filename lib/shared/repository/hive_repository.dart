// Package imports:
import 'package:hive_flutter/hive_flutter.dart';

// Project imports:
import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/repository/abstract_repository.dart';

class HiveRepositoryAsyncStreamImpl<T> implements HiveAsyncStreamRepository<T> {
  HiveRepositoryAsyncStreamImpl(this.boxName, {required this.key})
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
  T syncGet() {
    try {
      return _box.get(key)!;
    } catch (e) {
      logWarning('Error');
      rethrow;
    }
  }

  @override
  Future<T> put(T item) async {
    await Future.delayed(kMockNetworkLag, () => _box.put(key, item));
    return item;
  }

  @override
  Stream<T> listenable() => _box.watch(key: key).map((_) => syncGet()!);

  @override
  Future<T> get() => Future.delayed(kMockNetworkLag, syncGet);

  @override
  void dispose() {}
}

class HiveRepositorySyncImpl<T> implements HiveSyncRepository<T> {
  HiveRepositorySyncImpl(this.boxName, {required this.key})
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
  Future<T> put(T item) async {
    await _box.put(key, item);
    return item;
  }

  @override
  T? get() => _box.get(key);
}
