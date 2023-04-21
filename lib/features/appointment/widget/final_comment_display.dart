import 'package:leafy_leasing/shared/base.dart';

class FinalCommentDisplay extends ConsumerWidget {
  const FinalCommentDisplay(
    this.id, {
    super.key,
  });
  final String id;
  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    return ref.watch(appointmentProvider(id)).whenFine((appointment) => Card(
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
                        color:
                            appointment.isCanceled ? Colors.red : Colors.green,
                        size: 50,
                      ),
                      const Gap(sPadding),
                      Text(appointment.status.labelText(ctx),
                          textAlign: TextAlign.center,
                          style: ctx.tt.labelLarge!.copyWith(fontSize: 15),)
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
                            : ctx.lc.noCommentFound,
                        style: ctx.tt.bodyMedium!.copyWith(
                            color: appointment.hasComment
                                ? ctx.thm.hintColor
                                : ctx.thm.disabledColor,),
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),),
              ],
            ),
          ),
        ),);
  }
}
