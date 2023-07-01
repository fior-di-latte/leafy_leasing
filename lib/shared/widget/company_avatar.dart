// Project imports:
import 'package:leafy_leasing/shared/base.dart';

class CompanyAvatar extends ConsumerWidget {
  const CompanyAvatar({
    required this.customerId,
    super.key,
  });

  final String customerId;

  static Widget fromAppointment({required String appointmentId, Key? key}) {
    return Consumer(
      builder: (context, ref, _) =>
          ref.watch(appointmentStateProvider(appointmentId)).whenFine(
                (appointment) => CompanyAvatar(
                  customerId: appointment.customerId,
                  key: key,
                ),
              ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      ref.watch(customerStateProvider(customerId)).whenFine(
            (customer) => SizedBox(
              width: 72,
              height: 72,
              child: Material(
                shape: const CircleBorder(),
                elevation: 6,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => logger.i(
                    'This would direct you to the customer profile page ',
                  ),
                  child: CircleAvatar(
                    backgroundColor:
                        stringToColor(customer.companyName, context),
                    child: Text(customer.companyName.substring(0, 2)),
                  ),
                ),
              ),
            ),
          );
}
