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
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        FittedBox(
          fit: BoxFit.fitWidth,
          child: InkWell(
            onTap: onTap,
            child: Text(
              fn.rupiahCurrency.format(amount),
              style: headerFontWhite.copyWith(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed,
              ),
            ),
          ),
        ),
      ],
    );
  }
}