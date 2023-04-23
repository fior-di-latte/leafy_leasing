import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:leafy_leasing/bootstrap_app.dart';
import 'package:leafy_leasing/shared/base.dart';

Future<void> main() async {
  final stagingEnv = DotEnv();
  await stagingEnv.load(fileName: Assets.dotenvStaging);
  await dotenv.load(fileName: Assets.dotenvGlobal, mergeWith: stagingEnv.env);
  bootstrap();
}
