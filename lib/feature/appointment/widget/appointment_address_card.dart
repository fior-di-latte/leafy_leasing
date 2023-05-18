// Project imports:
import 'package:leafy_leasing/shared/base.dart';

class CustomerAddressCard extends HookConsumerWidget {
  const CustomerAddressCard({
    required this.address,
    required this.city,
    required this.zip,
    super.key,
  });

  static Widget fromAppointment(String id) => Consumer(
        builder: (context, ref, _) =>
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
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: context.height * .1,
      child: Card(
        child: InkWell(
          borderRadius: kBorderRadius,
          onTap: () => logger.i('This would open Google Maps'),
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
                      style: context.tt.displayMedium,
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
