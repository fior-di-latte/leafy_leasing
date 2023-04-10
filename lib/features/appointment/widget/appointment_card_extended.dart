import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/provider/appointment_provider.dart';
import 'package:leafy_leasing/shared/provider/customer_provider.dart';

class AppointmentCardExtended extends HookConsumerWidget with UiLoggy {
  const AppointmentCardExtended(this.id, {Key? key}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext ctx, WidgetRef ref) => Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
              shape: const RoundedRectangleBorder(borderRadius: kBorderRadius),
              child: Padding(
                padding: const EdgeInsets.all(lPadding),
                child: ref.watch(appointmentProvider(id)).whenFine(
                    (appointment) => ref
                        .watch(customerProvider(appointment.customerId))
                        .whenFine((customer) => _InnerExtendedCard(
                            appointment: appointment, customer: customer))),
              )),
          Positioned(
              left: -12,
              top: -12,
              child: CompanyAvatar.fromAppointment(
                appointmentId: id,
              ))
        ],
      );
}

class _InnerExtendedCard extends StatelessWidget {
  const _InnerExtendedCard({
    required this.appointment,
    required this.customer,
    super.key,
  });
  final Appointment appointment;
  final Customer customer;

  @override
  Widget build(BuildContext ctx) {
    return Column(
      children: [
        const Gap(40),
        Row(
          children: [
            const Icon(Icons.business_outlined, size: kIconSizeOnCards),
            const Gap(8),
            Expanded(
              child: AutoSizeText(
                customer.companyName,
                style: ctx.tt.displayMedium,
                maxLines: 2,
                maxFontSize: 34,
              ),
            )
          ],
        ),
        Gap(mPadding),
        Transform.scale(
          alignment: Alignment(-.72, -1),
          scale: .65,
          child: Row(
            children: [
              Icon(Icons.location_on_outlined,
                  size: kIconSizeOnCards, color: ctx.thm.disabledColor),
              const Gap(8),
              Expanded(
                child: AutoSizeText(
                  customer.city,
                  style: ctx.tt.bodyMedium!
                      .copyWith(color: ctx.thm.disabledColor, fontSize: 45),
                  maxLines: 1,
                  maxFontSize: 45,
                ),
              )
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: FittedBox(
                child: ActionChip(
                  avatar: Icon(
                    Icons.calendar_month_outlined,
                  ),
                  label: Text(
                    RelativeTime(ctx).format(appointment.date),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            Gap(lPadding),
            Expanded(
                child: FittedBox(
              child: ActionChip(
                avatar: Icon(
                  Icons.timer_outlined,
                ),
                label: Text(appointment.durationInMinutes.toString() + ' min',
                    style: TextStyle(color: Colors.black)),
              ),
            )),
          ],
        )
      ],
    );
  }
}
