import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/provider/appointment_provider.dart';
import 'package:leafy_leasing/shared/provider/customer_provider.dart';

class CompanyAvatar extends ConsumerWidget with UiLoggy {
  const CompanyAvatar({
    required this.customerId,
    super.key,
  });

  final String customerId;

  static Widget fromAppointment({required String appointmentId, Key? key}) {
    return Consumer(
        builder: (ctx, ref, _) => ref
            .watch(appointmentProvider(appointmentId))
            .whenFine((appointment) => CompanyAvatar(
                  customerId: appointment.customerId,
                  key: key,
                )));
  }

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    return ref
        .watch(customerProvider(customerId))
        .whenFine((customer) => SizedBox(
            width: 72,
            height: 72,
            child: Material(
              shape: const CircleBorder(),
              elevation: 8,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => loggy.info(
                    'This would direct you to the customer profile page '),
                child: CircleAvatar(
                  backgroundColor: stringToColor(customer.companyName, ctx),
                  child: Text(customer.companyName.substring(0, 2)),
                ),
              ),
            )));
  }
}
