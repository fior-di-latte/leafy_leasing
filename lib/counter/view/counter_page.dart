import 'package:leafy_leasing/shared/base.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.more_vert_outlined)),
            ],
            leading: const Padding(
              padding: EdgeInsets.all(kSPadding),
              child: CircleAvatar(
                foregroundImage: AssetImage(AppAssets.logo),
              ),
            ),
            title: Text(
              ctx.lc.appTitle,
            )),
        body: Container());
  }
}
