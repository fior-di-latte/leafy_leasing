import 'package:leafy_leasing/features/cancel_appointment/widget/who_canceled_radio_buttons.dart';
import 'package:leafy_leasing/shared/base.dart';

import '../../close_appointment/widget/success_radiobuttons.dart';

@RoutePage()
class CancelAppointmentScreen extends HookConsumerWidget with UiLoggy {
  const CancelAppointmentScreen(@PathParam() this.id, {Key? key})
      : super(key: key);

  final String id;

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    final canceledByCustomer = useLoggedState<bool?>(null);
    final hasChosenAlready = canceledByCustomer.value != null;
    final commentTextController = useTextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text(ctx.lc.cancelAppointmentTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.all(lPadding),
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedPositioned(
                      duration: 450.milliseconds,
                      curve: Curves.easeOut,
                      top: hasChosenAlready ? 0 : 200,
                      child: WhoCanceledRadioButtons(
                          canceledByCustomer: canceledByCustomer),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: lPadding),
                          child: AnimatedSwitcher(
                            switchInCurve: Curves.easeIn,
                            duration: 260.milliseconds,
                            child: hasChosenAlready
                                ? const SizedBox.shrink()
                                : Text(
                                    'Who canceled\nthe appointment?',
                                    style: ctx.tt.headlineLarge!.copyWith(
                                        color: ctx.cs.onBackground,
                                        fontStyle: FontStyle.italic),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: lPadding),
                          child: AnimatedSwitcher(
                            switchInCurve: Curves.easeIn,
                            duration: 260.milliseconds,
                            child: hasChosenAlready
                                ?
                                // Textfield with input decoration and caption: 'Comment (optional')
                                CommentTextField(commentTextController)
                                : const SizedBox.shrink(),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Gap(mPadding),
              Expanded(
                  flex: 2,
                  child: Center(
                      child: Hero(
                          tag: kCancelButtonHeroTag,
                          child: AppointmentActionButton.cancelFinalize(
                              ctx, ref,
                              comment: commentTextController.text,
                              newStatus:
                                  _getNewStatus(canceledByCustomer.value),
                              isGreyedOut: !hasChosenAlready,
                              id: id))))
            ],
          ),
        ));
  }

  AppointmentStatus? _getNewStatus(bool? canceledByCustomer) {
    if (canceledByCustomer == null) {
      return null;
    }
    return canceledByCustomer
        ? AppointmentStatus.canceledCustomer
        : AppointmentStatus.canceledUs;
  }
}
