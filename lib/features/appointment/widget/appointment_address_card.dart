import 'package:leafy_leasing/shared/base.dart';

class CustomerAddressCard extends HookConsumerWidget with UiLoggy {
  const CustomerAddressCard({
    required this.address,
    required this.city,
    required this.zip,
    super.key,
  });

  static Widget fromAppointment(String id) => Consumer(
        builder: (ctx, ref, _) =>
            ref.watch(appointmentStateProvider(id)).whenFine(
                  (appointment) => ref
                      .watch(customerStateProvider(appointment.customerId))
                      .whenFine(
                        (customer) => CustomerAddressCard(
                          address: customer.address,
                          city: customer.city,
                          zip: customer.zip,
                        ),
                      ),
                ),
      );

  final String address;
  final String city;
  final String zip;

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    return SizedBox(
      height: ctx.height * .1,
      child: Card(
        child: InkWell(
          borderRadius: kBorderRadius,
          onTap: () => loggy.info('This would open Google Maps'),
          child: Padding(
            padding: const EdgeInsets.all(lPadding),
            child: Row(
              children: [
                const Icon(Icons.directions_outlined, size: kIconSizeOnCards),
                const Gap(8),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '$address, $zip $city',
                      style: ctx.tt.displayMedium,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
