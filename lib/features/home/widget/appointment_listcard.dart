// Project imports:
import 'package:leafy_leasing/shared/base.dart';

class AppointmentListCard extends HookConsumerWidget with UiLoggy {
  const AppointmentListCard(this.id, {super.key});
  static const heightFactor = .25;
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) => Container(
        margin: const EdgeInsets.all(lPadding),
        height: context.height * heightFactor,
        child: Stack(
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
                              (customer) => _InnerCard(
                                appointment: appointment,
                                customer: customer,
                              ).animate().fadeIn(),
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
              const Gap(50),
              Row(
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
              const Gap(12),
              Row(
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
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ActionChip(
                      labelStyle: const TextStyle(color: Colors.black),
                      elevation: 20,
                      surfaceTintColor: context.cs.secondary,
                      avatar: const Icon(
                        Icons.calendar_month_outlined,
                      ),
                      label: Text(
                        RelativeTime(context).format(appointment.date),
                      ),
                    ),
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
          ),
        )
      ],
    );
  }
}
