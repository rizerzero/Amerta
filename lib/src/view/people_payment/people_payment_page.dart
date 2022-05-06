import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../model/model/payment/payment_model.dart';
import '../../model/model/payment/payment_summary_parameter.dart';
import '../../utils/utils.dart';
import '../../view_model/payment/payment_summary_notifier.dart';
import '../../view_model/payment/payments_notifier.dart';
import '../form_payment/form_payment_modal.dart';
import '../modal/modal_remove_payment/modal_remove_payment.dart';

part 'widgets/payment_list.dart';
part 'widgets/detail_information.dart';

class PeoplePaymentPage extends ConsumerWidget {
  const PeoplePaymentPage({
    Key? key,
    required this.transactionId,
    required this.peopleId,
  }) : super(key: key);

  final String transactionId;
  final String peopleId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final param = PaymentSummaryParameter(
      peopleId: peopleId,
      transactionId: transactionId,
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Consumer(
          builder: (context, ref, child) {
            final id = ref.watch(getPaymentSummary(param)).value?.transactionId;
            return Text("$id", style: bodyFontWhite.copyWith(fontSize: 14.0));
          },
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(getPaymentSummary(param));
            ref.invalidate(getPayments(transactionId));
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
            builder: (context) => FormPaymentModal(
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
