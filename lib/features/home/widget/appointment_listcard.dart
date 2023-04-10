import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/provider/customer_provider.dart';

import '../../../shared/provider/appointment_provider.dart';

class AppointmentListCard extends HookConsumerWidget with UiLoggy {
  const AppointmentListCard(this.id, {Key? key}) : super(key: key);
  static const heightFactor = .25;
  final String id;
  @override
  Widget build(BuildContext ctx, WidgetRef ref) => Container(
        margin: const EdgeInsets.all(lPadding),
        height: ctx.height * heightFactor,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Material(
              borderRadius: kBorderRadius,
              child: InkWell(
                borderRadius: kBorderRadius,
                onTap: () => ctx.router.push(AppointmentRoute(id: id)),
                child: Card(
                  shape:
                      const RoundedRectangleBorder(borderRadius: kBorderRadius),
                  child: Padding(
                    padding: const EdgeInsets.all(lPadding),
                    child: ref.watch(appointmentProvider(id)).whenFine(
                        (appointment) => ref
                            .watch(customerProvider(appointment.customerId))
                            .whenFine((customer) => _InnerCard(
                                appointment: appointment, customer: customer))),
                  ),
                ),
              ),
            ),
            Positioned(
                left: -12,
                top: -12,
                child: CompanyAvatar.fromAppointment(
                  appointmentId: id,
                ))
          ],
        ),
      );
}

class _InnerCard extends StatelessWidget {
  const _InnerCard({
    required this.appointment,
    required this.customer,
    super.key,
  });

  final Appointment appointment;
  final Customer customer;
  @override
  Widget build(BuildContext ctx) {
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
                      style: ctx.tt.displayMedium!.copyWith(fontSize: 40),
                      minFontSize: 12,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  )
                ],
              ),
              const Gap(12),
              Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      size: 40, color: ctx.thm.disabledColor),
                  const Gap(8),
                  Expanded(
                    child: AutoSizeText(
                      customer.city,
                      style: ctx.tt.bodyMedium!
                          .copyWith(color: ctx.thm.disabledColor, fontSize: 25),
                      minFontSize: 12,
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
                        labelStyle: TextStyle(color: Colors.black),
                        elevation: 20,
                        surfaceTintColor: ctx.cs.secondary,
                        avatar: Icon(
                          Icons.calendar_month_outlined,
                        ),
                        label: Text(
                          RelativeTime(ctx).format(appointment.date),
                        ),
                      ),
                      Transform.scale(
                        alignment: Alignment.centerRight,
                        scale: .8,
                        child: ActionChip(
                          avatar: Icon(
                            Icons.timer_outlined,
                          ),
                          label: Text(appointment.durationInMinutes.toString() +
                              ' min'),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ))
      ],
    );
  }
}
