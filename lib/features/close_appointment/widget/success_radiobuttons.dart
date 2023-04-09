import 'package:leafy_leasing/shared/base.dart';

class SuccessRadioButtons extends StatelessWidget {
  const SuccessRadioButtons({
    super.key,
    required this.canceledByCustomer,
  });

  final ValueNotifier<bool?> canceledByCustomer;

  @override
  Widget build(BuildContext ctx) {
    return Container(
      height: 200,
      width: ctx.width * .9,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {
              canceledByCustomer.value = true;
            },
            subtitle: Text(
              '(Name of customer as subtitle)',
              style: ctx.tt.bodySmall!.copyWith(
                color: ctx.cs.onBackground.withOpacity(.7),
              ),
            ),
            title: Text(ctx.lc.yesSuccessful),
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
            title: Text(ctx.lc.noAborted),
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
