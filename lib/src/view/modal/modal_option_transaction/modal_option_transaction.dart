import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection.dart';
import '../../../model/model/transaction/print_transaction_parameter.dart';
import '../../../model/model/transaction/transaction_model.dart';
import '../../../utils/utils.dart';
import '../../welcome/widgets/option_tile.dart';
import '../../widgets/modal_error.dart';
import '../../widgets/modal_loading.dart';
import '../modal_remove_transaction/modal_remove_transaction.dart';

class ModalOptionTransaction extends ConsumerWidget {
  const ModalOptionTransaction({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Listen [printTranscationNotifier] when user generate PDF
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
            padding: const EdgeInsets.only(bottom: 16.0),
            icon: Icons.edit_outlined,
            title: "Edit Transaksi",
            subtitle: "Mengupdate transaksi yang telah dibuat sebelumnya",
            sideColor: primary,
            onTap: () => context.pushNamed(
              transactionFormEditRouteNamed,
              params: {"transactionId": transaction.id},
            ),
          ),
          OptionTile(
            padding: const EdgeInsets.only(bottom: 16.0),
            icon: Icons.delete_outline,
            title: "Hapus Transaksi",
            subtitle: "Menghapus transaksi akan menghapus detail transaksinya juga",
            sideColor: Colors.red,
            onTap: () async => await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => ModalRemoveTransaction(transactionId: transaction.id),
            ),
          ),
          OptionTile(
            padding: const EdgeInsets.only(bottom: 16.0),
            icon: Icons.print_outlined,
            title: "Cetak Transaksi",
            subtitle: "Cetak transaksi dengan kode ${transaction.id}",
            sideColor: secondaryLight,
            onTap: () async {
              final parameter = PrintTransactionParameter(
                transactionId: transaction.id,
                peopleId: transaction.people?.peopleId ?? "",
                printTransactionType: transaction.type.toPrintType(),
              );

              await ref.read(printTransactionNotifier.notifier).printSingleTransaction(parameter);
            },
          ),
        ],
      ),
    );
  }
}
