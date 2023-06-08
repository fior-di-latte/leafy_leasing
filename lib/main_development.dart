// Project imports:
import 'dart:async';

import 'package:leafy_leasing/shared/base.dart';

Future<void> main() async {
  final devEnv = DotEnv();
  await devEnv.load(fileName: Assets.dotenvDev);
  await dotenv.load(fileName: Assets.dotenvGlobal, mergeWith: devEnv.env);
  unawaited(bootstrap());
}
