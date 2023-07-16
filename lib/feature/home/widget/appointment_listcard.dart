// Project imports:
import 'package:leafy_leasing/shared/base.dart';

class AppointmentListCard extends HookConsumerWidget {
  const AppointmentListCard(this.id, {super.key});
  static const _heightFactor = .25;
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) => Container(
        margin: const EdgeInsets.all(lPadding),
        height: context.height * _heightFactor,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            Card(
              shape: const RoundedRectangleBorder(borderRadius: kBorderRadius),
              child: InkWell(
                borderRadius: kBorderRadius,
                onTap: () => context.router.push(AppointmentRoute(id: id)),
                child: Padding(
                  padding: const EdgeInsets.all(lPadding),
                  child: ref.watch(appointmentStateProvider(id)).whenFine(
                        (appointment) => ref
                            .watch(
                              customerStateProvider(appointment.customerId),
                            )
                            .whenFine(
                              (customer) => Semantics(
                                value: '${customer.companyName} appointment',
                                label: '${customer.companyName} appointment',
                                child: _InnerCard(
                                  appointment: appointment,
                                  customer: customer,
                                ),
                              ),
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
        ),
      );
}

class _InnerCard extends StatelessWidget {
  const _InnerCard({
    required this.appointment,
    required this.customer,
  });

  final Appointment appointment;
  final Customer customer;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              const Spacer(
                flex: 3,
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    const Icon(Icons.business_outlined, size: 40),
                    const Gap(8),
                    Expanded(
                      child: AutoSizeText(
                        customer.companyName,
                        style: context.tt.displayMedium!.copyWith(fontSize: 40),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 40,
                      color: context.thm.disabledColor,
                    ),
                    const Gap(8),
                    Expanded(
                      child: AutoSizeText(
                        customer.city,
                        style: context.tt.bodyMedium!.copyWith(
                          color: context.thm.disabledColor,
                          fontSize: 25,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const VerticalDivider(
          indent: 50,
          endIndent: 40,
          width: 20,
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ActionChip(
                // labelStyle: const TextStyle(color: Colors.black),
                elevation: 5,
                surfaceTintColor: context.cs.secondary,
                avatar: const Icon(
                  Icons.calendar_month_outlined,
                ),
                label: Text(
                  RelativeTime(context).format(appointment.date),
                ),
              ),
              const Gap(8),
              Transform.scale(
                alignment: Alignment.centerRight,
                scale: .8,
                child: ActionChip(
                  avatar: const Icon(
                    Icons.timer_outlined,
                  ),
                  label: Text(
                    '${appointment.durationInMinutes} min',
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
