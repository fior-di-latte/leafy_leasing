// // Package imports:
// import 'dart:async';
//
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
//
// // Project imports:
// import 'package:leafy_leasing/shared/base.dart';
// import 'package:leafy_leasing/shared/repository/abstract_repository.dart';
//
// class HiveAsyncCachedRepositoryImpl<T> extends HiveAsyncCachedRepository<T> {
//   @override
//   // TODO: implement boxName
//   String get boxName => throw UnimplementedError();
//
//   @override
//   // TODO: implement cache
//   Cache<T> get cache => throw UnimplementedError();
//
//   @override
//   Future<void> delete() {
//     // TODO: implement delete
//     throw UnimplementedError();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//   }
//
//   @override
//   Future<T> getter([String? id]) {
//     // TODO: implement getter
//     throw UnimplementedError();
//   }
//
//   @override
//   // TODO: implement key
//   String get key => throw UnimplementedError();
//
//   @override
//   Stream<T> listenable() {
//     // TODO: implement listenable
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<T> putter(T item) {
//     // TODO: implement putter
//     throw UnimplementedError();
//   }
//
//   @override
//   T syncGet() {
//     // TODO: implement syncGet
//     throw UnimplementedError();
//   }
// }
//
// class HiveAsyncRepositoryImpl<T> extends HiveAsyncRepository<T> {
//   HiveAsyncRepositoryImpl(this.boxName, {required this.key})
//       : _box = Hive.box<T>(boxName);
//
//   @override
//   final String boxName;
//
//   @override
//   final String key;
//   final Box<T> _box;
//
//   @override
//   Future<void> delete() async {
//     await Future.delayed(kMockNetworkLag, () => _box.delete(key));
//   }
//
//   @override
//   T syncGet() {
//     try {
//       return _box.get(key)!;
//     } catch (e) {
//       logger.e('Error');
//       rethrow;
//     }
//   }
//
//   @override
//   Future<T> putter(T item) async {
//     await throwTimeOutErrorWhenManualInternetCheckFails();
//     // always update on original 'get' method. After a put,
//     // the repository (see optimistic put) is usually invalidated,
//     // meaning the data is fetched again from the backend.
//     await Future.delayed(kMockNetworkLag, () => _box.put(key, item));
//     return item;
//   }
//
//   @override
//   Stream<T> listenable() => _box.watch(key: key).map((_) => syncGet()!);
//
//   @override
//   Future<T> getter([String? id]) async {
//     await throwTimeOutErrorWhenManualInternetCheckFails();
//     return Future.delayed(kMockNetworkLag, syncGet);
//   }
//
//   @override
//   void dispose() {}
// }
//
import 'package:hive_flutter/hive_flutter.dart';

import 'package:leafy_leasing/shared/repository/abstract_repository.dart';

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
