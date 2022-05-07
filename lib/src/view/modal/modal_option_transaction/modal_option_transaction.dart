import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../model/model/transaction/recent_transaction_model.dart';
import '../../../utils/utils.dart';
import '../../welcome/widgets/option_tile.dart';
import '../modal_remove_transaction/modal_remove_transaction.dart';

class ModalOptionTransaction extends StatelessWidget {
  const ModalOptionTransaction({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final RecentTransactionModel transaction;

  @override
  Widget build(BuildContext context) {
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
              params: {"transactionId": transaction.transactionId},
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
              builder: (context) =>
                  ModalRemoveTransaction(transactionId: transaction.transactionId),
            ),
          ),
          OptionTile(
            padding: const EdgeInsets.only(bottom: 16.0),
            icon: Icons.print_outlined,
            title: "Cetak Transaksi",
            subtitle: "Cetak transaksi dengan kode ${transaction.transactionId}",
            sideColor: secondaryLight,
          ),
        ],
      ),
    );
  }
}
