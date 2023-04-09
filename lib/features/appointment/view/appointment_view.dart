import 'package:leafy_leasing/features/appointment/widget/appointment_address_card.dart';
import 'package:leafy_leasing/features/appointment/widget/appointment_card_extended.dart';
import 'package:leafy_leasing/shared/widget/close_or_cancel_buttons.dart';
import 'package:leafy_leasing/shared/base.dart';

import '../widget/appointment_contact_card.dart';

@RoutePage()
class AppointmentScreen extends HookConsumerWidget with UiLoggy {
  const AppointmentScreen(@PathParam() this.id, {Key? key}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    return Scaffold(
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
              AppointmentCardExtended(),
              Gap(mPadding),
              AppointmentAddressCard('Rofl'),
              Gap(mPadding),
              AppointmentContactCard(
                  name: 'Rofl', phone: 'Rofl', email: 'Rofl'),
              Gap(mPadding),
              Expanded(
                  child: Row(children: [
                Expanded(
                    child: Hero(
                        tag: kCancelButtonHeroTag,
                        child: AppointmentActionButton.cancel(ctx, id: id))),
                Gap(lPadding),
                Expanded(
                    child: Hero(
                        tag: kCloseButtonHeroTag,
                        child: AppointmentActionButton.close(ctx, id: id)))
              ])),
            ],
          ),
        ));
  }
}
