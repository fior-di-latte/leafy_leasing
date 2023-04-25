import 'package:leafy_leasing/features/home/provider/metas_provider.dart';
import 'package:leafy_leasing/shared/base.dart';

class PrecacheProvider extends StatelessWidget {
  const PrecacheProvider({
    required this.child,
    required this.provider,
    super.key,
  });
  final Widget child;
  final ProviderListenable<AsyncValue<Object?>> provider;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Offstage(
          child: Consumer(
            builder: (_, ref, __) {
              ref.watch(provider);
              return const SizedBox.shrink();
            },
          ),
        ),
        child
      ],
    );
  }
}

class SnackbarListener extends ConsumerWidget with UiLoggy {
  const SnackbarListener({required this.child, super.key});

  final Widget child;
  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    ref.listen(notificationProvider, (_, cb) => cb(ctx));
    return child;
  }
}

class WarmUp extends ConsumerWidget with UiLoggy {
  const WarmUp({this.providers, required this.child, super.key});

  final List<ProviderListenable<AsyncValue<Object?>>>? providers;
  final Widget child;

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    if (providers == null) {
      return child;
    }
    final states = providers!.map((p) => ref.watch(p));

    for (final state in states) {
      if (state is AsyncError) {
        logError('Error while warming up: ${state.error}');
      }
    }

    if (states.every((state) => state is AsyncData)) return child;
    return const FittedBox(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
