import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../model/model/transaction/recent_transaction_model.dart';
import '../../../utils/utils.dart';
import '../../modal/modal_option_transaction/modal_option_transaction.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    Key? key,
    this.padding,
    required this.transaction,
  }) : super(key: key);

  final EdgeInsetsGeometry? padding;

  final RecentTransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 24.0),
      child: Ink(
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 2.0,
              color: black.withOpacity(.25),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0).copyWith(
                bottomLeft: const Radius.circular(4.0),
                topLeft: const Radius.circular(4.0),
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              onLongPress: () async {
                await showModalBottomSheet(
                  context: context,
                  builder: (context) => ModalOptionTransaction(transaction: transaction),
                );
              },
              onTap: () {
                context.pushNamed(
                  peopleTransactionRouteNamed,
                  params: {
                    "peopleId": transaction.people.peopleId,
                    'transactionId': transaction.transactionId,
                  },
                );
              },
              title: Text(
                transaction.title,
                style: bodyFont.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8.0),
                  Text(
                    fn.rupiahCurrency(transaction.amount),
                    style: bodyFont.copyWith(
                      color: secondaryDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text.rich(
                    TextSpan(
                      text: "Reference : ",
                      children: [
                        TextSpan(text: "${transaction.people.name} "),
                        TextSpan(
                          text: "#${transaction.transactionId}",
                          style: bodyFont.copyWith(
                            fontWeight: FontWeight.bold,
                            color: primary,
                          ),
                        ),
                      ],
                    ),
                    style: bodyFont.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 8.0,
                      color: grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(60.0),
                          border: Border.all(color: secondaryLight),
                        ),
                        child: FractionallySizedBox(
                          widthFactor: transaction.amountPayment == null
                              ? 0
                              : fn.getPercentage(transaction.amountPayment!, transaction.amount) /
                                  100,
                          heightFactor: 1,
                          alignment: Alignment.centerLeft,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: secondaryLight,
                              borderRadius: BorderRadius.circular(60.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text.rich(
                        TextSpan(
                          text: fn.rupiahCurrency(transaction.amountPayment ?? 0),
                          children: [
                            TextSpan(
                              text:
                                  " (${fn.getPercentage(transaction.amountPayment ?? 0, transaction.amount)}%) ",
                              style: bodyFont.copyWith(
                                color: secondaryDark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        style: bodyFont.copyWith(
                          color: grey,
                          fontSize: 12.0,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
