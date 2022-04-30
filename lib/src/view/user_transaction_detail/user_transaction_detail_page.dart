import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../utils/utils.dart';

class UserTransactionDetailPage extends StatelessWidget {
  const UserTransactionDetailPage({
    Key? key,
    required this.transactionId,
    required this.userId,
  }) : super(key: key);
  final String transactionId;
  final String userId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        // centerTitle: true,
        title: Text(
          const Uuid().v4(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: primary,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(8.0),
                  ),
                ),
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Zeffry Reynando",
                        style: bodyFont.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Untuk Berbuka Puasa",
                        style: bodyFontWhite,
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Text(
                            DateFormat.yMMMMEEEEd().format(DateTime.now()),
                            style: bodyFontWhite.copyWith(fontSize: 12.0),
                          ),
                          Text(" - ", style: bodyFontWhite),
                          Text(
                            "Tidak ditentukan",
                            style: bodyFontWhite.copyWith(fontSize: 12.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40.0),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Nominal",
                                  style: bodyFontWhite.copyWith(color: Colors.white54),
                                ),
                                const SizedBox(height: 8.0),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    fn.rupiahCurrency.format(250000),
                                    style: bodyFontWhite.copyWith(
                                        fontWeight: FontWeight.bold, fontSize: 24.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Progress Pembayaran",
                                  style: bodyFontWhite.copyWith(color: Colors.white54),
                                ),
                                const SizedBox(height: 8.0),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    fn.rupiahCurrency.format(125000),
                                    style: bodyFontWhite.copyWith(
                                        fontWeight: FontWeight.bold, fontSize: 24.0),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      ...[
                        Container(
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                          child: FractionallySizedBox(
                            widthFactor: .5,
                            heightFactor: 1,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                color: secondaryLight,
                                borderRadius: BorderRadiusDirectional.circular(60.0),
                                border: Border.all(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text.rich(
                          TextSpan(
                            text: "Sisa pembayaran : ${fn.rupiahCurrency.format(125000)}",
                            children: [
                              TextSpan(
                                text: " (50%) ",
                                style: bodyFontWhite.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                          style: bodyFontWhite.copyWith(
                            fontSize: 8.0,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
