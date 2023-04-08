import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/models/appointment.dart';

class AppointmentListCard extends HookConsumerWidget with UiLoggy {
  const AppointmentListCard({Key? key}) : super(key: key);
  static const heightFactor = .25;
  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    final appointment = Appointment(
        id: 'kik',
        date: DateTime.now(),
        customerId: 'peterId',
        status: AppointmentStatus.pending,
        duration: Duration(hours: 2));
    return Container(
      margin: const EdgeInsets.all(kLPadding),
      height: ctx.height * heightFactor,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
            child: Padding(
              padding: const EdgeInsets.all(kLPadding),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Gap(50),
                        Row(
                          children: [
                            Icon(Icons.account_balance_outlined, size: 40),
                            Gap(8),
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
                        Gap(12),
                        Row(
                          children: [
                            Icon(Icons.directions_outlined,
                                size: 40, color: ctx.thm.disabledColor),
                            Gap(8),
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
                  VerticalDivider(
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
                              avatar: Icon(
                                Icons.calendar_month_outlined,
                              ),
                              label: Text(
                                'Today, 21.3',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Transform.scale(
                              alignment: Alignment.centerRight,
                              scale: .8,
                              child: ActionChip(
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
                    onTap: () => loggy.info(
                        'This would direct you to the customer profile page '),
                    child: CircleAvatar(
                        backgroundColor: ctx.cs.secondary, child: Text('F')),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
