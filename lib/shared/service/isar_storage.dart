import 'dart:io';

import 'package:leafy_leasing/shared/base.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

// Future<void> setupIsar() async {
//   final dir = await getApplicationDocumentsDirectory();
//   await Isar.open([SettingsSchema], directory: dir.path);
//   await _maybeFlushIsar();
// }

Future<void> _maybeFlushIsar() async {
  if (bool.parse(dotenv.get('FLUSH_ISAR_AND_HIVE'))) {
    logger.w('Flushing Isar...');
    final dir = await getApplicationDocumentsDirectory();
    await Directory(dir.path).delete(recursive: true);
  }
}
