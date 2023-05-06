// Project imports:
import 'package:leafy_leasing/shared/base.dart';

class FinalCommentDisplay extends ConsumerWidget {
  const FinalCommentDisplay(
    this.id, {
    super.key,
  });
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(appointmentStateProvider(id)).whenFine(
          (appointment) => Card(
            child: Padding(
              padding: const EdgeInsets.all(lPadding),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          appointment.status.icon,
                          color: appointment.isCanceled
                              ? Colors.red
                              : Colors.green,
                          size: 50,
                        ),
                        const Gap(sPadding),
                        Text(
                          appointment.status.labelText(context),
                          textAlign: TextAlign.center,
                          style: context.tt.labelLarge!.copyWith(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    indent: 20,
                    endIndent: 20,
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: AutoSizeText(
                        appointment.hasComment
                            ? appointment.comment!
                            : context.lc.noCommentFound,
                        style: context.tt.bodyMedium!.copyWith(
                          color: appointment.hasComment
                              ? context.thm.hintColor
                              : context.thm.disabledColor,
                        ),
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
