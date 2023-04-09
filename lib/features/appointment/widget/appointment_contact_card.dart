import 'package:leafy_leasing/shared/base.dart';

class AppointmentContactCard extends HookConsumerWidget with UiLoggy {
  const AppointmentContactCard(
      {required this.name, required this.phone, required this.email, Key? key})
      : super(key: key);

  final String name;
  final String phone;
  final String email;

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    return SizedBox(
      height: ctx.height * .13,
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(lPadding),
        child: Row(
          children: [
            const Icon(Icons.person_outline, size: kIconSizeOnCards),
            const Gap(8),
            Expanded(
              flex: 2,
              child: FittedBox(
                child: Text(
                  name,
                  style: ctx.tt.displayMedium,
                ),
              ),
            ),
            const VerticalDivider(width: 40),
            Expanded(
              child: FittedBox(
                child: IconButton(
                  icon: const Icon(Icons.email),
                  onPressed: () => loggy.info('This would email $email'),
                ),
              ),
            ),
            Expanded(
              child: FittedBox(
                child: IconButton(
                  icon: const Icon(Icons.phone),
                  onPressed: () => loggy.info('This would call $phone'),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
