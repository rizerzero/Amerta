import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../model/model/transaction/recent_transaction_model.dart';
import '../../../utils/utils.dart';
import '../../welcome/widgets/option_tile.dart';

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
            padding: EdgeInsets.only(bottom: 16.0),
            icon: Icons.delete_outline,
            title: "Hapus Transaksi",
            subtitle: "Menghapus transaksi akan menghapus detail transaksinya juga",
            sideColor: Colors.red,
          ),
          OptionTile(
            padding: EdgeInsets.only(bottom: 16.0),
            icon: Icons.picture_as_pdf_outlined,
            title: "Cetak Transaksi",
            subtitle:
                "Mencetak transaksi yang akan digenerate menjadi pdf yang siap untuk di share",
            sideColor: secondaryLight,
          ),
        ],
      ),
    );
  }
}
