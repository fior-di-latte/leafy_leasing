import 'dart:async';

import 'package:leafy_leasing/shared/base.dart';

import 'package:leafy_leasing/shared/repository/abstract_repository.dart';
import 'package:leafy_leasing/shared/repository/hive_repository.dart';

/// This class mocks an async network call (like a REST API call)
class HiveAsyncStreamNotifier<T> extends StateNotifier<AsyncValue<T>>
    with NetworkLoggy {
  HiveAsyncStreamNotifier(this.ref,
      {required String boxName, required this.key,})
      : repository = HiveRepositoryAsyncStreamImpl<T>(boxName, key: key),
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
      repository.listenable().listen((newValue) {
        loggy.info('Hive Async value: $newValue');
        state = AsyncValue.data(newValue);
      });
    });
  }

  final AutoDisposeRef ref;
  final HiveAsyncStreamRepository<T> repository;
  final String key;

  Future<void> put(T item) async {
    await repository.put(item);
  }

  Future<void> delete() async {
    await repository.delete();
  }
}
