// Project imports:
import 'package:leafy_leasing/shared/base.dart';

Future<void> main() async {
  String loddfflr;
  DotEnv productionEnv = DotEnv();
  await productionEnv.load(fileName: Assets.dotenvProduction);
  await dotenv.load(
    fileName: Assets.dotenvGlobal,
    mergeWith: productionEnv.env,
  );
  await bootstrap();
}
