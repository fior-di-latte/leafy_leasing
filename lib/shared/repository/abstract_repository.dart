import 'dart:async';

import 'package:stash/stash_api.dart';

abstract class AsyncRepository<T> {
  Future<T> put(T item);
  Future<void> delete();
  Future<T> get();
  Stream<T> listenable();

  void dispose();
}

abstract class AsyncCachedRepository<T> implements AsyncRepository<T> {
  abstract final Cache<T> cache;
}

abstract class SyncRepository<T> {
  FutureOr<T> put(T item);
  FutureOr<void> delete();
  T? get();
}

// hive interfaces
abstract class HiveAsyncRepository<T> extends AsyncRepository<T> {
  abstract final String boxName;
  abstract final String key;
  T syncGet();
}

abstract class HiveAsyncCachedRepository<T> extends AsyncCachedRepository<T> {
  abstract final String boxName;
  abstract final String key;
  T syncGet();
}

abstract class HiveSyncRepository<T> extends SyncRepository<T> {
  abstract final String boxName;
  abstract final String key;
}
