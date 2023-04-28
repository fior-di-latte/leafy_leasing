// Project imports:
import 'package:leafy_leasing/shared/base.dart';

class CustomerContactCard extends HookConsumerWidget with UiLoggy {
  const CustomerContactCard({
    required this.name,
    required this.phone,
    required this.email,
    super.key,
  });

  static Widget fromAppointment(String id) => Consumer(
        builder: (context, ref, _) =>
            ref.watch(appointmentStateProvider(id)).whenFine(
                  (appointment) => ref
                      .watch(customerStateProvider(appointment.customerId))
                      .whenFine(
                        (customer) => CustomerContactCard(
                          name: customer.nameContact,
                          phone: customer.phone,
                          email: customer.email,
                        ),
                      ),
                ),
      );

  final String name;
  final String phone;
  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: context.height * .13,
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
                    style: context.tt.displayMedium,
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
        ),
      ),
    );
  }
}
