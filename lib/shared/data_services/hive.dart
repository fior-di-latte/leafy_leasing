import 'package:hive_flutter/hive_flutter.dart';

const themeModeBox = 'themeModeBox';

extension BoxExtensions on Box {
  Stream<BoxEvent> watchWithInitial({required String key}) {
    Future.delayed(Duration(milliseconds: 10), () {
      var obj = get(key);
      put(key, obj);
    });
    return watch(key: key);
  }
}

// Future setupHive() async {
//   await Hive.initFlutter();
//   await _maybeDeleteBoxes();
//   // Hive.registerAdapter<ProofMeta>(ProofMetaAdapter());
//   await _openBoxes();
//   _maybeSetInitialValues();
// }
//
// Future _openBoxes() async {
//   try {
//     // generic type = field type, index can be auto incremented or custom
//     return Future.wait([
//       Hive.openBox<ThemeMode>(proofOverviewLastSeenBox),
//     ]);
//   } catch (e) {
//     logError(
//         'Hive box opening failed due to improper app closing before. Exception: \n $e');
//   }
// }
