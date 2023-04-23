import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:leafy_leasing/bootstrap_app.dart';
import 'package:leafy_leasing/shared/base.dart';

Future<void> main() async {
  final devEnv = DotEnv();
  await devEnv.load(fileName: Assets.dotenvDev);
  await dotenv.load(fileName: Assets.dotenvGlobal, mergeWith: devEnv.env);
  bootstrap();
}
