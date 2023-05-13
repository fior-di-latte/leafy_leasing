// Project imports:
import 'package:leafy_leasing/features/close_appointment/widget/success_radiobuttons.dart';
import 'package:leafy_leasing/shared/base.dart';

@RoutePage()
class CloseAppointmentView extends HookConsumerWidget with UiLoggy {
  const CloseAppointmentView(@PathParam() this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wasSuccessful = useLoggedState<bool?>(null);
    final hasChosenAlready = wasSuccessful.value != null;
    final commentTextController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.lc.closeAppointmentTitle),
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
                    child: SuccessRadioButtons(
                      canceledByCustomer: wasSuccessful,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: lPadding),
                        child: AnimatedSwitcher(
                          switchInCurve: Curves.easeIn,
                          duration: 260.milliseconds,
                          child: hasChosenAlready
                              ? const SizedBox.shrink()
                              : Text(
                                  context.lc.wasAppointmentSuccessful,
                                  style: context.tt.headlineLarge!.copyWith(
                                    color: context.cs.onBackground,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: lPadding),
                        child: AnimatedSwitcher(
                          switchInCurve: Curves.easeIn,
                          duration: 260.milliseconds,
                          child: hasChosenAlready
                              ?
                              // Textfield with input decoration and caption:
                              // 'Comment (optional')
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
                  tag: kCloseButtonHeroTag,
                  child: AppointmentActionButton.closeFinalize(
                    context,
                    ref,
                    commentTextController: commentTextController,
                    newStatus: _getNewStatus(wasSuccessful.value),
                    isGreyedOut: !hasChosenAlready,
                    id: id,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppointmentStatus? _getNewStatus(bool? wasSuccessful) {
    if (wasSuccessful == null) {
      return null;
    }
    return wasSuccessful
        ? AppointmentStatus.doneSuccessful
        : AppointmentStatus.doneAborted;
  }
}
