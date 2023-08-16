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
          scrolledUnderElevation: 0,
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
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(lPadding),
          child: Column(
            children: [
              Stack(
                children: [
                  AppointmentCardExtended(id),
                  Align(
                      alignment: Alignment.topRight, child: _CloudSyncIcon(id))
                ],
              ),
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

class _CloudSyncIcon extends HookConsumerWidget {
  const _CloudSyncIcon(String this.id, {Key? key}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(appointmentStateProvider(id)).whenFine((appointment) {
      return HookBuilder(
        builder: (context) {
          _maybeDownloadAppointment(appointment, ref);

          return Padding(
            padding: const EdgeInsets.all(mPadding),
            child: AnimatedSwitcher(
                duration: 300.milliseconds,
                child: appointment.isOfflineAvailable
                    ? Tooltip(
                        message: 'Offline verfügbar',
                        child: Transform.translate(
                          offset: const Offset(-5, 5),
                          child: Icon(Icons.cloud_download_outlined,
                              key: ValueKey('offline_enabled'),
                              color: context.cs.primary),
                        ),
                      )
                    : Tooltip(
                        message: 'Wird gedownloaded ...',
                        child: Stack(
                          children: [
                            CircularProgressIndicator(),
                            Transform.translate(
                              offset: const Offset(5, 5),
                              child: Icon(
                                Icons.cloud_off_outlined,
                                key: ValueKey('offline_not_enabled'),
                              ),
                            ),
                          ],
                        ),
                      )),
          );
        },
      );
    });
  }

  void _maybeDownloadAppointment(Appointment appointment, WidgetRef ref) {
    useEffect(() {
      if (!appointment.isOfflineAvailable) {
        logger.i('Downloading appointment $id');
        ref.watch(appointmentStateProvider(id).notifier).download();
      }
      return null;
    }, []);
  }
}
