import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../model/model/transaction/print_transaction_parameter.dart';
import '../../../model/model/transaction/summary_transaction_model.dart';
import '../../../utils/utils.dart';
import '../../../view_model/transaction/print_transaction_notifier.dart';
import '../../welcome/widgets/option_tile.dart';
import '../../widgets/modal_error.dart';
import '../../widgets/modal_loading.dart';

class ModalOptionPrintTransaction extends ConsumerWidget {
  const ModalOptionPrintTransaction({
    Key? key,
    required this.data,
  }) : super(key: key);

  final SummaryTransactionModel data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<Uint8List?>>(printTransactionNotifier.select((value) => value.item),
        (_, state) {
      if (state is AsyncLoading) {
        showDialog(
          context: context,
          builder: (context) => const ModalLoadingWidget(),
        );
      } else {
        /// Close loading modal
        Navigator.pop(context);
        state.whenOrNull(
          data: (_) => context.pushNamed(previewPDFRouteNamed),
          error: (error, trace) => showDialog(
            context: context,
            builder: (context) => ModalErrorWidget(message: "$error"),
          ),
        );
      }
    });
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          OptionTile(
            title: "Cetak Hutang",
            subtitle: "Mencetak semua transaksi Hutang ${data.people.name}",
            padding: const EdgeInsets.only(bottom: 16.0),
            onTap: () async {
              await ref.watch(printTransactionNotifier.notifier).printTransaction(
                    PrintTransactionParameter(
                      people: data.people,
                      printTransactionType: PrintTransactionType.hutang,
                      paymentStatus: PaymentStatus.notPaidOff,
                    ),
                  );
            },
          ),
          OptionTile(
            title: "Cetak Piutang",
            subtitle: "Mencetak semua transaksi Piutang ${data.people.name}",
            padding: const EdgeInsets.only(bottom: 16.0),
            sideColor: primaryShade2,
            onTap: () async {
              await ref.watch(printTransactionNotifier.notifier).printTransaction(
                    PrintTransactionParameter(
                      people: data.people,
                      printTransactionType: PrintTransactionType.piutang,
                      paymentStatus: PaymentStatus.notPaidOff,
                    ),
                  );
            },
          ),
          OptionTile(
            title: "Cetak Hutang & Piutang",
            subtitle: "Mencetak semua transaksi Hutang dan Piutang ${data.people.name}",
            sideColor: primaryShade4,
            onTap: () async {
              await ref.watch(printTransactionNotifier.notifier).printTransaction(
                    PrintTransactionParameter(
                      people: data.people,
                      printTransactionType: PrintTransactionType.hutangDanPiutang,
                      paymentStatus: PaymentStatus.notPaidOff,
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}
