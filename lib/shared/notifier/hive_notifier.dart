import 'package:leafy_leasing/shared/base.dart';

import 'package:leafy_leasing/shared/repository/abstract_repository.dart';
import 'package:leafy_leasing/shared/repository/hive_repository.dart';

class HiveStateNotifier<T> extends StateNotifier<T> with NetworkLoggy {
  HiveStateNotifier(this.ref, {required String boxName, required this.key})
      : repository = HiveRepositoryImpl<T>(boxName, key: key),
        super(HiveRepositoryImpl<T>(boxName, key: key).syncGet() as T) {
    repository.keyObservable().listen((event) {
      loggy.info('Hive new event: $event');
      if (event.value != null) {
        state = event.value as T;
      }
    });
  }

  final AutoDisposeRef ref;
  final HiveRepository<T> repository;
  final String key;
}

/// This class mocks an async network call (like a REST API call)
class HiveAsyncStateNotifier<T> extends StateNotifier<AsyncValue<T>>
    with NetworkLoggy {
  HiveAsyncStateNotifier(this.ref, {required String boxName, required this.key})
      : repository = HiveRepositoryImpl<T>(boxName, key: key),
        super(AsyncValue<T>.loading()) {
    // this is a little hacky because async initialization is a little troublesome
    // using the old riverpod providers. riverpod Notifier + code gen would fix that,
    // but not today! :)
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

  Future<void> update(T item) async {
    await repository.put(item);
  }

  Future<void> delete() async {
    await repository.delete();
  }
}
