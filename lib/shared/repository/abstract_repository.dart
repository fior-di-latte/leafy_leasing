abstract class AsyncRepository<T> {
  Future<T> put(T item);
  Future<void> delete();
  Future<T> get();
  Stream<T> listenable();

  void dispose();
}

abstract class SyncRepository<T> {
  Future<T> put(T item);
  Future<void> delete();
  T? get();
}

abstract class HiveAsyncStreamRepository<T> extends AsyncRepository<T> {
  abstract final String boxName;
  abstract final String key;
  T syncGet();
}

abstract class HiveSyncRepository<T> extends SyncRepository<T> {
  abstract final String boxName;
  abstract final String key;
}
