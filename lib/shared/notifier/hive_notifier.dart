import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:leafy_leasing/shared/base.dart';

import 'package:leafy_leasing/shared/repository/abstract_repository.dart';
import 'package:leafy_leasing/shared/repository/hive_repository.dart';

/// This class mocks an async network call (like a REST API call)
class HiveAsyncStateNotifier<T> extends StateNotifier<AsyncValue<T>>
    with NetworkLoggy {
  HiveAsyncStateNotifier(this.ref, {required String boxName, required this.key})
      : repository = HiveRepositoryImpl<T>(boxName, key: key),
        super(AsyncValue<T>.loading()) {
    // this is a little hacky because async initialization is a little troublesome
    // using the old riverpod providers. riverpod Notifier + code gen would fix that,
    // but not today! :)

    // this is needed because sometimes a network call is awaited in
    // the provider that finishes after the provider is disposed.
    ref.disposeDelay(2.seconds);

    Future.delayed(kMockNetworkLag, () {
      final startValue = repository.syncGet();
      state = startValue != null
          ? AsyncValue.data(startValue)
          : AsyncValue<T>.loading();
      repository.keyObservable().listen((event) {
        loggy.info('Hive Async new event: $event');
        if (event.value != null) {
          state = AsyncValue.data(event.value as T);
        }
      });
    });
  }

  final AutoDisposeRef ref;
  final HiveRepository<T> repository;
  final String key;

  Future<void> put(T item) async {
    await repository.put(item);
  }

  Future<void> delete() async {
    await repository.delete();
  }
}

class HiveNotifier<T> extends StateNotifier<T> with NetworkLoggy {
  HiveNotifier(this.ref,
      {required String boxName, required this.key, T? defaultValue})
      : repository = HiveRepositoryImpl<T>(boxName, key: key),
        super(Hive.box<T>(boxName).get(boxName, defaultValue: defaultValue)!) {
    repository.keyObservable().listen((event) {
      loggy.info('Hive Sync new event: $event');
      if (event.value != null) {
        state = event.value as T;
      }
    });
  }

  final AutoDisposeRef ref;
  final HiveRepository<T> repository;
  final String key;

  Future<void> update(T item) async {
    await repository.put(item);
  }

  Future<void> delete() async {
    await repository.delete();
  }
}

class HiveAsyncNotifierV2<T> extends AsyncNotifier<T> with NetworkLoggy {
  HiveAsyncNotifierV2({required String boxName, required this.key})
      : repository = HiveRepositoryImpl<T>(boxName, key: key);
  final HiveRepository<T> repository;
  final String key;

  Future<void> put(T item) async {
    await repository.put(item);
  }

  Future<void> delete() async {
    await repository.delete();
  }

  @override
  FutureOr<T> build() {
    // this is a little hacky because async initialization is a little troublesome
    // using the old riverpod providers. riverpod Notifier + code gen would fix that,
    // but not today! :)

    // this is needed because sometimes a network call is awaited in
    // the provider that finishes after the provider is disposed.
    // ref.disposeDelay(2.seconds);

    return Future.delayed(kMockNetworkLag, () {
      repository.keyObservable().listen((event) {
        loggy.info('Hive Async new event: $event');
        // if (event.value != null) {
        //   state = AsyncValue.data(event.value as T);
      });
      return repository.syncGet()!;
    });
  }
}
