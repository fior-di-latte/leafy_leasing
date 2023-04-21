import 'package:leafy_leasing/features/appointment/widget/appointment_address_card.dart';
import 'package:leafy_leasing/features/appointment/widget/appointment_card_extended.dart';
import 'package:leafy_leasing/features/appointment/widget/appointment_contact_card.dart';
import 'package:leafy_leasing/features/appointment/widget/final_comment_display.dart';
import 'package:leafy_leasing/shared/base.dart';

@RoutePage()
class AppointmentScreen extends StatelessWidget with UiLoggy {
  const AppointmentScreen(@PathParam() this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext ctx) => Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(sPadding),
                child: CircleAvatar(
                  foregroundImage: AssetImage(AppAssets.logo),
                ),
              ),
              Text(
                ctx.lc.appointmentTitle,
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
                child: Consumer(
                  builder: (context, ref, _) {
                    return ref.watch(appointmentProvider(id)).whenFine(
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
                                      ctx,
                                      id: id,
                                    ),
                                  ),
                                ),
                                const Gap(lPadding),
                                Expanded(
                                  child: Hero(
                                    tag: kCloseButtonHeroTag,
                                    child: AppointmentActionButton.close(
                                      ctx,
                                      id: id,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                  },
                ),
              ),
            ],
          ),
        ),
      );
}
