import 'dart:io';

import 'package:leafy_leasing/shared/base.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stash_isar/stash_isar.dart';

part 'isar_cache.g.dart';

@riverpod
Future<IsarCacheStore> isarCacheStore(IsarCacheStoreRef ref) async {
  await _maybeFlushIsar();
  final dir = await getApplicationDocumentsDirectory();
  return newIsarLocalCacheStore(path: dir.path);
}

// delete everything from Isar database
Future<void> _maybeFlushIsar() async {
  if (dotenv.get('FLUSH_ISAR_AND_HIVE') == 'true') {
    logWarning('Flushing Isar...');
    final dir = await getApplicationDocumentsDirectory();
    await Directory(dir.path).delete(recursive: true);
  }
}

extension AddLoggedCache on IsarCacheStore {
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

    return addLoggersToIsarCache(newCache, name: usedName);
  }
}
