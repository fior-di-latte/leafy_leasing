import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/models/appointment.dart';

class AppointmentListCard extends HookConsumerWidget with UiLoggy {
  const AppointmentListCard(this.id, {Key? key}) : super(key: key);
  static const heightFactor = .25;
  final String id;
  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    final appointment = Appointment(
        id: 'kik',
        date: DateTime.now().add(1.days),
        customerId: 'peterId',
        status: AppointmentStatus.pending,
        durationInMinutes: 2);
    return Container(
      margin: const EdgeInsets.all(lPadding),
      height: ctx.height * heightFactor,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          InkWell(
            borderRadius: kBorderRadius,
            onTap: () => ctx.router.push(AppointmentRoute(id: id)),
            child: Card(
              shape: const RoundedRectangleBorder(borderRadius: kBorderRadius),
              child: Padding(
                padding: const EdgeInsets.all(lPadding),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Gap(50),
                          Row(
                            children: [
                              const Icon(Icons.business_outlined, size: 40),
                              const Gap(8),
                              Expanded(
                                child: FittedBox(
                                  child: Text(
                                    'Flux Life',
                                    style: ctx.tt.displayMedium,
                                  ),
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
                                child: FittedBox(
                                  child: Text(
                                    'Köln Sülz',
                                    style: ctx.tt.bodyMedium!
                                        .copyWith(color: ctx.thm.disabledColor),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const VerticalDivider(
                      indent: 20,
                      endIndent: 20,
                      width: 20,
                    ),
                    Expanded(
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
                                child: const ActionChip(
                                  avatar: Icon(
                                    Icons.timer_outlined,
                                  ),
                                  label: Text('3h'),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              left: -12,
              top: -12,
              child: SizedBox(
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
                        backgroundColor: ctx.cs.secondary,
                        child: const Text('F')),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
