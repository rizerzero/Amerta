import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/utils.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    Key? key,
    this.padding,
  }) : super(key: key);

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
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
                  onTap: () {
                    context.pushNamed(
                      userTransactionRouteNamed,
                      params: {
                        "userId": const Uuid().v4(),
                        'transactionId': const Uuid().v4(),
                      },
                    );
                  },
                  title: Text(
                    "Buat buka puasa bersama",
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
                        fn.rupiahCurrency.format(250000),
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
                            const TextSpan(text: "Zeffry Reynando "),
                            TextSpan(
                              text: "#${const Uuid().v4()}",
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
                              widthFactor: .5,
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
                          const SizedBox(height: 4.0),
                          Text.rich(
                            TextSpan(
                              text: fn.rupiahCurrency.format(125000),
                              children: [
                                TextSpan(
                                  text: " (50%) ",
                                  style: bodyFont.copyWith(
                                    color: secondaryDark,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            style: bodyFont.copyWith(
                              color: grey,
                              fontSize: 8.0,
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
        ),
        Positioned(
          top: -5,
          right: -15,
          child: RotationTransition(
            turns: const AlwaysStoppedAnimation(45 / 360),
            child: Card(
              color: Colors.deepPurple,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "Piutang",
                  style: bodyFont.copyWith(
                    fontSize: 10.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
