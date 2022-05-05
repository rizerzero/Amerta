import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class SummaryAmount extends StatelessWidget {
  const SummaryAmount({
    Key? key,
    this.title = 'Hutang',
    this.amount = 0,
    this.onTap,
  }) : super(key: key);

  final String title;
  final int amount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: bodyFontWhite.copyWith(
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 60.0,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: InkWell(
              onTap: onTap,
              child: Text(
                fn.rupiahCurrency(amount, prefix: "Rp."),
                style: headerFontWhite.copyWith(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dashed,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
