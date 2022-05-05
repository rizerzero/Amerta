import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../model/model/transaction_detail/transaction_detail_model.dart';
import '../../model/model/transaction_detail/transaction_detail_summary_parameter.dart';
import '../../utils/utils.dart';
import '../../view_model/transaction_detail/transaction_detail_summary_notifier.dart';
import '../../view_model/transaction_detail/transactions_detail_notifier.dart';
import '../form_transaction_detail/form_transaction_detail_modal.dart';
import '../modal/modal_remove_transaction_detail/modal_remove_transaction_detail.dart';

part 'widgets/detail_transaction_list.dart';
part 'widgets/detail_information.dart';

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
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Consumer(
          builder: (context, ref, child) {
            final id = ref.watch(getTransactionDetailSummary(param)).value?.transactionId;
            return Text("$id", style: bodyFontWhite.copyWith(fontSize: 14.0));
          },
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(getTransactionDetailSummary(param));
            ref.invalidate(getTransactionsDetail(transactionId));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: fn.vh(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _DetailInformation(param: param),
                  const SizedBox(height: 16.0),
                  _DetailTransactionList(transactionId: transactionId),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => FormTransactionDetailModal(
              id: null,
              peopleId: peopleId,
              transactionId: transactionId,
            ),
          );
        },
        label: Text('Cicil', style: bodyFontWhite),
        backgroundColor: Colors.deepOrange,
        icon: const Icon(Icons.payments_outlined),
      ),
    );
  }
}
