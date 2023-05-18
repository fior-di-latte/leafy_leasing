// Project imports:
import 'package:leafy_leasing/shared/base.dart';

class AppointmentCardExtended extends HookConsumerWidget {
  const AppointmentCardExtended(this.id, {super.key});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) => Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            shape: const RoundedRectangleBorder(borderRadius: kBorderRadius),
            child: Padding(
              padding: const EdgeInsets.all(lPadding),
              child: ref.watch(appointmentStateProvider(id)).whenFine(
                    (appointment) => ref
                        .watch(customerStateProvider(appointment.customerId))
                        .whenFine(
                          (customer) => _InnerExtendedCard(
                            appointment: appointment,
                            customer: customer,
                          ),
                        ),
                  ),
            ),
          ),
          Positioned(
            left: -12,
            top: -12,
            child: CompanyAvatar.fromAppointment(
              appointmentId: id,
            ),
          )
        ],
      );
}

class _InnerExtendedCard extends StatelessWidget {
  const _InnerExtendedCard({
    required this.appointment,
    required this.customer,
  });
  final Appointment appointment;
  final Customer customer;

  @override
  Widget build(BuildContext context) {
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
                style: context.tt.displayMedium,
                maxLines: 2,
                maxFontSize: 34,
              ),
            )
          ],
        ),
        const Gap(mPadding),
        Transform.scale(
          alignment: const Alignment(-.72, -1),
          scale: .65,
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: kIconSizeOnCards,
                color: context.thm.disabledColor,
              ),
              const Gap(8),
              Expanded(
                child: AutoSizeText(
                  customer.city,
                  style: context.tt.bodyMedium!
                      .copyWith(color: context.thm.disabledColor, fontSize: 45),
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
                  avatar: const Icon(
                    Icons.calendar_month_outlined,
                  ),
                  label: Text(
                    RelativeTime(context).format(appointment.date),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            const Gap(lPadding),
            Expanded(
              child: FittedBox(
                child: ActionChip(
                  avatar: const Icon(
                    Icons.timer_outlined,
                  ),
                  label: Text(
                    '${appointment.durationInMinutes} min',
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
