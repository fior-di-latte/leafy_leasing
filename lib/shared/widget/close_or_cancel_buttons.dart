// Project imports:
import 'package:leafy_leasing/features/home/provider/metas_provider.dart';
import 'package:leafy_leasing/shared/base.dart';

abstract class AppointmentActionButton extends StatelessWidget with UiLoggy {
  const AppointmentActionButton({
    required this.foregroundColor,
    required this.labelText,
    required this.onTap,
    required this.icon,
    this.isGreyedOut = false,
    super.key,
  });
  factory AppointmentActionButton.cancel(
    BuildContext context, {
    required String id,
    Key? key,
  }) =>
      _Button(
        onTap: () => context.router.push(CancelAppointmentRoute(id: id)),
        icon: Icons.cancel_outlined,
        foregroundColor: context.cs.error,
        labelText: context.lc.cancelAppointment,
        key: key,
      );

  factory AppointmentActionButton.cancelFinalize(
    BuildContext context,
    WidgetRef ref, {
    required String id,
    required AppointmentStatus? newStatus,
    required TextEditingController commentTextController,
    bool isGreyedOut = false,
    Key? key,
  }) =>
      _Button(
        icon: Icons.cancel_outlined,
        onTap: () {
          logInfo(
            'Cancel appointment with id $id. New status $newStatus,'
            ' Comment ${commentTextController.text}',
          );

          ref.read(metasStateProvider.notifier).cancelAppointment(id);
          ref.read(appointmentStateProvider(id).notifier).cancelAppointment(
                newStatus: newStatus!,
                comment: commentTextController.text,
              );
          context.router.navigate(const HomeRoute());
        },
        foregroundColor: context.cs.error,
        labelText: context.lc.cancelAppointmentNow,
        isGreyedOut: isGreyedOut,
        key: key,
      );

  factory AppointmentActionButton.closeFinalize(
    BuildContext context,
    WidgetRef ref, {
    required String id,
    required TextEditingController commentTextController,
    AppointmentStatus? newStatus,
    bool isGreyedOut = false,
    Key? key,
  }) =>
      _Button(
        icon: Icons.check_circle_outline,
        onTap: () {
          logInfo(
            'Cancel appointment with id $id. New status $newStatus,'
            ' Comment ${commentTextController.text}',
          );
          ref.read(appointmentStateProvider(id).notifier).closeAppointment(
                newStatus: newStatus!,
                comment: commentTextController.text,
              );
          ref.read(metasStateProvider.notifier).closeAppointment(id);
          context.router.navigate(const HomeRoute());
        },
        isGreyedOut: isGreyedOut,
        foregroundColor: context.cs.primary,
        labelText: context.lc.closeAppointmentNow,
        key: key,
      );

  factory AppointmentActionButton.close(
    BuildContext context, {
    required String id,
    Key? key,
  }) =>
      _Button(
        icon: Icons.check_circle_outline,
        onTap: () => context.router.push(CloseAppointmentRoute(id: id)),
        foregroundColor: context.cs.primary,
        labelText: context.lc.closeAppointment,
        key: key,
      );

  final IconData icon;
  final VoidCallback onTap;
  final bool isGreyedOut;
  final Color foregroundColor;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    Widget current = OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: foregroundColor,
      ),
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Expanded(child: FittedBox(child: Icon(icon))),
          Expanded(
            child: FittedBox(
              child: Text(
                labelText,
                textAlign: TextAlign.center,
                style: context.tt.labelSmall,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
    if (isGreyedOut) {
      current = IgnorePointer(child: Opacity(opacity: 0.3, child: current));
    }

    return current;
  }
}

class _Button extends AppointmentActionButton {
  const _Button({
    required super.onTap,
    required super.foregroundColor,
    required super.labelText,
    required super.icon,
    super.isGreyedOut,
    super.key,
  });
}
