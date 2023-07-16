// ====================
// ISAR MOBILE SOLUTION

// import 'dart:io';
// import 'package:leafy_leasing/shared/base.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:stash_isar/stash_isar.dart';
//
// part 'stash_cache.g.dart';
//
// @riverpod
// Future<IsarCacheStore> cacheStore(CacheStoreRef ref) async {
//   await _maybeFlushIsar();
//   final dir = await getApplicationDocumentsDirectory();
//   return newIsarLocalCacheStore(path: dir.path);
// }
//
// // delete everything from Isar database
// Future<void> _maybeFlushIsar() async {
//   if (bool.parse(dotenv.get('FLUSH_ISAR_AND_HIVE'))) {
//     logger.w('Flushing Isar...');
//     final dir = await getApplicationDocumentsDirectory();
//     await Directory(dir.path).delete(recursive: true);
//   }
// }
//
// extension AddLoggedCache on CacheStore {
//   Future<Cache<T>> createLoggedCache<T>({
//     required T Function(Map<String, dynamic>) fromJson,
//     String? name,
//   }) async {
//     final usedName = name ?? T.toString();
//     final newCache = await cache<T>(
//       fromEncodable: fromJson,
//       name: usedName,
//       maxEntries: kNumberOfCacheItems,
//       eventListenerMode: EventListenerMode.synchronous,
//     );
//
//     return addLoggersToCache(newCache, name: usedName);
//   }
// }

//   // ====================
//   // SEMBAST WEB SOLUTION
//
import 'package:leafy_leasing/shared/base.dart';
import 'package:stash_sembast/stash_sembast.dart';
import 'package:stash_sembast_web/stash_sembast_web.dart';

part 'stash_cache.g.dart';

@riverpod
Future<SembastCacheStore> cacheStore(CacheStoreRef ref) =>
    newSembastWebCacheStore();

// delete everything from Isar database

extension AddLoggedCache on CacheStore {
  Future<Cache<T>> createLoggedCache<T>({
    required T Function(Map<String, dynamic>) fromJson,
    String? name,
  }) async {
    final usedName = name ?? T.toString();
    final newCache = await cache<T>(
      fromEncodable: fromJson,
      name: usedName,
      maxEntries: kNumberOfCacheItems,
      eventListenerMode: EventListenerMode.synchronous,
    );

    return addLoggersToCache(newCache, name: usedName);
  }
}

class NoCache<T> implements Cache<T> {
  @override
  Future<T?> get(String key, {CacheEntryDelegate<T>? delegate}) async => null;

  @override
  Future<void> put(
    String key,
    T value, {
    CacheEntryDelegate<T>? delegate,
  }) async {
    return;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
