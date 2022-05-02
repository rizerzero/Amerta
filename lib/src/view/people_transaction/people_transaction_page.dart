import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../model/model/transaction_detail/transaction_detail_summary_parameter.dart';
import '../../utils/utils.dart';
import '../../view_model/transaction_detail/future_provider.dart';
import '../people_transaction_detail/widgets/modal_form_transaction_detail.dart';
import '../people_transaction_detail/widgets/modal_remove_transaction_detail.dart';

class PeopleTransactionPage extends ConsumerWidget {
  const PeopleTransactionPage({
    Key? key,
    required this.transactionId,
    required this.peopleId,
  }) : super(key: key);
  final String transactionId;
  final String peopleId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final param = TransactionDetailSummaryParameter(
      peopleId: peopleId,
      transactionId: transactionId,
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const ModalFormTransactionDetail(),
          );
        },
        label: Text('Cicil', style: bodyFontWhite),
        backgroundColor: Colors.deepOrange,
        icon: const Icon(Icons.payments_outlined),
      ),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          const Uuid().v4(),
          style: bodyFontWhite.copyWith(fontSize: 14.0),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.refresh(getTransactionDetailSummary(param));

            ref.refresh(getTransactionsDetail(transactionId));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: fn.vh(context) / 3),
                    child: Consumer(
                      builder: (context, ref, child) {
                        final _future = ref.watch(getTransactionDetailSummary(param));

                        return _future.when(
                          data: (data) {
                            return Padding(
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
                                        text:
                                            "Sisa pembayaran : ${fn.rupiahCurrency.format(125000)}",
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
                            );
                          },
                          error: (error, trace) =>
                              Center(child: Text("$error", style: bodyFontWhite)),
                          loading: () =>
                              const Center(child: CircularProgressIndicator(color: Colors.white)),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: fn.vh(context) / 4),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final _future = ref.watch(getTransactionsDetail(transactionId));
                      return _future.when(
                        data: (data) {
                          return ListView.builder(
                            itemCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              return const TransactionDetailCard();
                            },
                          );
                        },
                        error: (error, trace) => Center(child: Text("$error")),
                        loading: () => const Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 100.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TransactionDetailCard extends StatelessWidget {
  const TransactionDetailCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: secondaryDark,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.yMMMMEEEEd().format(DateTime.now()),
                  style: bodyFontWhite.copyWith(
                    fontSize: 16.0,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: ListTile.divideTiles(
              context: context,
              color: grey,
              tiles: List.generate(
                3,
                (index) => ListTile(
                  isThreeLine: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        child: Text("${index + 1}"),
                        backgroundColor: secondaryLight,
                        foregroundColor: Colors.white,
                        radius: 15.0,
                      ),
                    ],
                  ),
                  title: Text(
                    "#${const Uuid().v4()}",
                    style: bodyFont.copyWith(
                      fontSize: 10.0,
                      color: primary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8.0),
                      Text(
                        fn.rupiahCurrency.format(250000),
                        style: bodyFont.copyWith(
                          color: secondaryDark,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () async {
                              await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => const ModalFormTransactionDetail(),
                              );
                            },
                            style: TextButton.styleFrom(
                              side: const BorderSide(color: primary),
                            ),
                            child: Text(
                              "Edit",
                              style: bodyFont.copyWith(color: primary),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          OutlinedButton(
                            onPressed: () async {
                              await showDialog(
                                context: context,
                                builder: (context) => const ModalRemoveTransactionDetail(),
                              );
                            },
                            style: TextButton.styleFrom(
                              side: const BorderSide(color: Colors.red),
                            ),
                            child: Text(
                              "Hapus",
                              style: bodyFont.copyWith(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ).toList(),
            ).toList(),
          ),
        ],
      ),
    );
  }
}
