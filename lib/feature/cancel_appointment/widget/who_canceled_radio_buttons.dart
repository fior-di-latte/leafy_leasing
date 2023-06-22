// Project imports:
import 'package:leafy_leasing/shared/base.dart';

class WhoCanceledRadioButtons extends StatelessWidget {
  const WhoCanceledRadioButtons({
    super.key,
    required this.canceledByCustomer,
  });

  final ValueNotifier<bool?> canceledByCustomer;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: context.width * .9,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {
              canceledByCustomer.value = true;
            },
            subtitle: Text(
              '(${context.lc.customerNameAsSubtitle})',
              style: context.tt.bodySmall!.copyWith(
                color: context.cs.onBackground.withOpacity(.7),
              ),
            ),
            title: Text(context.lc.customerCanceled),
            leading: Radio(
              value: true,
              groupValue: canceledByCustomer.value,
              onChanged: (_) => canceledByCustomer.value = true,
            ),
          ),
          ListTile(
            onTap: () {
              canceledByCustomer.value = false;
            },
            title: Text(context.lc.weCanceled),
            leading: Radio(
              value: false,
              groupValue: canceledByCustomer.value,
              onChanged: (_) => canceledByCustomer.value = true,
            ),
          ),
        ],
      ),
    );
  }
}
