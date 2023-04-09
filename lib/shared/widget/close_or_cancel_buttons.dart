import 'package:leafy_leasing/shared/base.dart';

abstract class AppointmentActionButton extends StatelessWidget with UiLoggy {
  factory AppointmentActionButton.cancel(BuildContext ctx,
          {required String id, Key? key}) =>
      _Button(
          onTap: () => ctx.router.push(CancelAppointmentRoute(id: id)),
          icon: Icons.cancel_outlined,
          foregroundColor: ctx.cs.error,
          labelText: ctx.lc.cancelAppointment,
          key: key);

  factory AppointmentActionButton.cancelFinalize(
          BuildContext ctx, WidgetRef ref,
          {required String id, bool isGreyedOut = false, Key? key}) =>
      _Button(
          icon: Icons.cancel_outlined,
          onTap: () {
            logInfo('Finalize cancel appointment');
            ctx.router.navigate(const HomeRoute());
          },
          foregroundColor: ctx.cs.error,
          labelText: ctx.lc.cancelAppointmentNow,
          isGreyedOut: isGreyedOut,
          key: key);

  factory AppointmentActionButton.closeFinalize(BuildContext ctx, WidgetRef ref,
          {required String id, bool isGreyedOut = false, Key? key}) =>
      _Button(
          icon: Icons.check_circle_outline,
          onTap: () {
            logInfo('Finalize close appointment');
            ctx.router.navigate(const HomeRoute());
          },
          isGreyedOut: isGreyedOut,
          foregroundColor: ctx.cs.primary,
          labelText: ctx.lc.closeAppointmentNow,
          key: key);

  factory AppointmentActionButton.close(BuildContext ctx,
          {required String id, Key? key}) =>
      _Button(
          icon: Icons.check_circle_outline,
          onTap: () => ctx.router.push(CloseAppointmentRoute(id: id)),
          foregroundColor: ctx.cs.primary,
          labelText: ctx.lc.closeAppointment,
          key: key);

  const AppointmentActionButton(
      {required this.foregroundColor,
      required this.labelText,
      required this.onTap,
      required this.icon,
      this.isGreyedOut = false,
      Key? key})
      : super(key: key);

  final IconData icon;
  final VoidCallback onTap;
  final bool isGreyedOut;
  final Color foregroundColor;
  final String labelText;

  @override
  Widget build(BuildContext ctx) {
    Widget current = OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: foregroundColor,
        ),
        onPressed: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Expanded(child: FittedBox(child: Icon(icon))),
            Expanded(
                child: FittedBox(
                    child: Text(labelText,
                        textAlign: TextAlign.center,
                        style: ctx.tt.labelSmall))),
            Spacer(),
          ],
        ));
    if (isGreyedOut) {
      current = IgnorePointer(child: Opacity(opacity: 0.3, child: current));
    }

    return current;
  }
}

class _Button extends AppointmentActionButton {
  const _Button(
      {required VoidCallback onTap,
      required Color foregroundColor,
      required String labelText,
      required IconData icon,
      bool isGreyedOut = false,
      Key? key})
      : super(
            foregroundColor: foregroundColor,
            labelText: labelText,
            onTap: onTap,
            icon: icon,
            isGreyedOut: isGreyedOut,
            key: key);
}
