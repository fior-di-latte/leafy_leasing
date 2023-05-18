// Project imports:
import 'package:leafy_leasing/feature/appointment/widget/appointment_address_card.dart';
import 'package:leafy_leasing/feature/appointment/widget/appointment_card_extended.dart';
import 'package:leafy_leasing/feature/appointment/widget/appointment_contact_card.dart';
import 'package:leafy_leasing/feature/appointment/widget/final_comment_display.dart';
import 'package:leafy_leasing/shared/base.dart';

@RoutePage()
class AppointmentView extends ConsumerWidget {
  const AppointmentView(@PathParam() this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(sPadding),
                child: CircleAvatar(
                  foregroundImage: AssetImage(Assets.imageLogo),
                ),
              ),
              Text(
                context.lc.appointmentTitle,
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(lPadding),
          child: Column(
            children: [
              AppointmentCardExtended(id),
              const Gap(mPadding),
              CustomerAddressCard.fromAppointment(id),
              const Gap(mPadding),
              CustomerContactCard.fromAppointment(id),
              const Gap(mPadding),
              Expanded(
                child: ref.watch(appointmentStateProvider(id)).whenFine(
                      (appointment) => Visibility(
                        visible:
                            appointment.status == AppointmentStatus.pending,
                        replacement: FinalCommentDisplay(id),
                        child: Row(
                          children: [
                            Expanded(
                              child: Hero(
                                tag: kCancelButtonHeroTag,
                                child: AppointmentActionButton.cancel(
                                  context,
                                  id: id,
                                ),
                              ),
                            ),
                            const Gap(lPadding),
                            Expanded(
                              child: Hero(
                                tag: kCloseButtonHeroTag,
                                child: AppointmentActionButton.close(
                                  context,
                                  id: id,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
              ),
            ],
          ),
        ),
      );
}
