import 'dart:io';

import 'package:leafy_leasing/shared/base.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stash/stash_api.dart';
import 'package:stash_isar/stash_isar.dart';

part 'isar_cache.g.dart';

@riverpod
Future<IsarCacheStore> isarCacheStore(IsarCacheStoreRef ref) async {
  await _maybeFlushIsar();
  final dir = await getApplicationDocumentsDirectory();
  final store = await newIsarLocalCacheStore(path: dir.path);
  return store;
}

@riverpod
Future<Cache<Appointment>> appointmentCache(AppointmentCacheRef ref) async {
  final store = await ref.watch(isarCacheStoreProvider.future);
  return store.cache<Appointment>(
    fromEncodable: Appointment.fromJson,
    name: 'Appointment',
    maxEntries: 3,
    eventListenerMode: EventListenerMode.synchronous,
  );
}

// delete everything from Isar database
Future<void> _maybeFlushIsar() async {
  if (dotenv.get('FLUSH_ISAR_AND_HIVE') == 'true') {
    logWarning('Flushing Isar...');
    final dir = await getApplicationDocumentsDirectory();
    await Directory(dir.path).delete(recursive: true);
  }
}
