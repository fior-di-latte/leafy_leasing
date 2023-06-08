import 'dart:async';

import 'package:leafy_leasing/shared/constants.dart';
import 'package:leafy_leasing/shared/logging.dart';
import 'package:retry/retry.dart';
import 'package:stash/stash_api.dart';

abstract class AsyncRepository<T> {
  Future<void> delete();

  Future<T> getter([String? id]);
  Future<T> putter(T item, {String? id});

  Stream<T> listenable();

  void dispose();

  Future<T> asyncWrapper(
    Future<T> Function() function, {
    String? loggingKey,
    bool isPut = false,
  }) async {
    return retry(
      function,
      maxAttempts: kNumberPutRetries,
      onRetry: (e) => logOnNetworkRetry<T>(loggingKey, e, isPut: isPut),
    );
  }

  Future<T> get([String? id]) => asyncWrapper(() => getter(id), loggingKey: id);
  Future<void> put(T item, {String? id}) =>
      asyncWrapper(() => putter(item, id: id), loggingKey: item.toString());
}

abstract class AsyncCachedRepository<T> extends AsyncRepository<T> {
  abstract final Cache<T> cache;

  @override
  Future<T> get([String? id]) => asyncWrapper(
        () async {
          try {
            final incomingValue = await getter(id);
            // update cache
            await cache.put(id ?? 'globalKey', incomingValue);
            return incomingValue;
          } catch (e) {
            // check if cache fallback is available
            final cachedFallback = await cache.get(id ?? 'globalKey');
            if (cachedFallback != null) {
              logger.i(
                '😅 Cache Fallback Used! Found $id in cache, returning $cachedFallback',
              );
              return cachedFallback;
            }

            // no incoming value && no cache fallback -> rethrow Error
            logger.w('No incoming value and no cache fallback for $id');
            rethrow;
          }
        },
        loggingKey: id,
      );
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

// abstract class HiveNewAsyncCachedRepository<T>
//     extends AsyncCachedRepository<T> {
//   abstract final StandardHiveAsyncModelClient<T> client;
//   @override
//   Future<T> getter([String? id]) => client.get(id!);
//
//   @override
//   Future<T> putter(T item, {String? id}) => client.put(id!, item);
// }

abstract class HiveSyncRepository<T> extends SyncRepository<T> {
  abstract final String boxName;
  abstract final String key;
}
