import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/utils.dart';

class TransactionDebtTile extends StatelessWidget {
  const TransactionDebtTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
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
          child: Container(
            margin: const EdgeInsets.only(left: 4.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0).copyWith(
                bottomLeft: const Radius.circular(4.0),
                topLeft: const Radius.circular(4.0),
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              isThreeLine: true,
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
                  const SizedBox(height: 8.0),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -15,
          right: -15,
          child: RotationTransition(
            turns: const AlwaysStoppedAnimation(45 / 360),
            child: Card(
              color: Colors.deepPurple,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
