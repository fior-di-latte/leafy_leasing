import 'package:leafy_leasing/shared/base.dart';

import '../../../shared/models/appointment.dart';

class AppointmentCardExtended extends HookConsumerWidget with UiLoggy {
  const AppointmentCardExtended({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    final appointment = Appointment(
        id: 'kik',
        date: DateTime.now(),
        customerId: 'peterId',
        status: AppointmentStatus.pending,
        duration: 2.hours);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          shape: const RoundedRectangleBorder(borderRadius: kBorderRadius),
          child: Padding(
            padding: const EdgeInsets.all(lPadding),
            child: Column(
              children: [
                const Gap(24),
                Row(
                  children: [
                    const Icon(Icons.business_outlined, size: kIconSizeOnCards),
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
                Transform.scale(
                  alignment: Alignment(-.72, -1),
                  scale: .65,
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          size: kIconSizeOnCards, color: ctx.thm.disabledColor),
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
                  ),
                ),
                Row(
                  children: const [
                    Expanded(
                      flex: 2,
                      child: FittedBox(
                        child: ActionChip(
                          avatar: Icon(
                            Icons.calendar_month_outlined,
                          ),
                          label: Text(
                            'Today, 21.3',
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
                          label: Text('3h'),
                        ),
                      ),
                    ),
                  ],
                )
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
    );
  }
}
