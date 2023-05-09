// Package imports:
import 'package:hive_flutter/hive_flutter.dart';

// Project imports:
import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/repository/abstract_repository.dart';
import 'package:retry/retry.dart';
import 'package:stash/src/api/cache/cache.dart';

class HiveAsyncCachedRepositoryImpl<T> extends HiveAsyncRepositoryImpl<T>
    implements HiveAsyncCachedRepository<T> {
  HiveAsyncCachedRepositoryImpl(
    super.boxName, {
    required super.key,
    required this.cache,
  });

  @override
  final Cache<T> cache;

  @override
  Future<T> put(T item) async {
    // always update on original 'get' method. After a put,
    // the repository (see optimistic put) is usually invalidated,
    // meaning the data is fetched again from the backend.

    // logInfo('putting $item in cache');
    // await cache.put(key, item);
    return super.put(item);
  }

  @override
  Future<T> get() async {
    try {
      final incomingValue = await super.get();
      // update cache
      await cache.put(key, incomingValue);
      return incomingValue;
    } catch (e) {
      // check if cache fallback is available
      final cachedFallback = await cache.get(key);
      if (cachedFallback != null) {
        logInfo('found $key in cache, returning $cachedFallback');
        return cachedFallback;
      }

      // no incoming value && no cache fallback -> rethrow Error
      logWarning('No incoming value and no cache fallback for $key');
      rethrow;
    }
  }
}

class HiveAsyncRepositoryImpl<T> implements HiveAsyncRepository<T> {
  HiveAsyncRepositoryImpl(this.boxName, {required this.key})
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
    // throw Exception;
    await retry(
      () => Future.delayed(kMockNetworkLag, () => _box.put(key, item)),
      maxAttempts: kNumberPutRetries,
      onRetry: (e) => logOnNetworkRetry<T>(key, e),
    );
    return item;
  }

  @override
  Stream<T> listenable() => _box.watch(key: key).map((_) => syncGet()!);

  @override
  Future<T> get() => retry(
        () => Future.delayed(kMockNetworkLag, syncGet),
        maxAttempts: kNumberGetRetries,
        onRetry: (e) => logOnNetworkRetry<T>(key, e),
      );

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
