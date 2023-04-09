import 'package:leafy_leasing/shared/base.dart';

class AppointmentAddressCard extends HookConsumerWidget with UiLoggy {
  const AppointmentAddressCard(this.address, {Key? key}) : super(key: key);

  final String address;

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    return InkWell(
      borderRadius: kBorderRadius,
      onTap: () => loggy.info(('This would open Google Maps')),
      child: SizedBox(
        height: ctx.height * .1,
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(lPadding),
          child: Row(
            children: [
              const Icon(Icons.directions_outlined, size: kIconSizeOnCards),
              const Gap(8),
              Expanded(
                child: FittedBox(
                  child: Text(
                    address,
                    style: ctx.tt.displayMedium,
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
