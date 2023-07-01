import 'package:leafy_leasing/shared/base.dart';

class SettingsButtonNavRail extends StatelessWidget {
  const SettingsButtonNavRail({
    super.key,
    required this.isWideLandscape,
  });

  final bool isWideLandscape;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 52),
        child: Transform.translate(
          offset: Offset(isWideLandscape ? -10 : 0, 0),
          child: InkWell(
            onTap: () => context.router.push(const SettingsRoute()),
            borderRadius: kBorderRadius,
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 30),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onPressed: () => context.router.push(const SettingsRoute()),
                    icon: const Icon(
                      Icons.more_vert_outlined,
                    ),
                  ),
                  if (isWideLandscape) ...[
                    const Gap(18),
                    Text(
                      'Settings',
                      style: context.thm.textTheme.labelMedium,
                    )
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
