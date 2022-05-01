import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../../welcome/widgets/option_tile.dart';

class ModalMoreOptionUser extends StatelessWidget {
  const ModalMoreOptionUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          OptionTile(
            title: "Edit Profile",
            subtitle: "Mengkoreksi profile kamu jika terjadi kesalahan.",
            icon: Icons.edit_outlined,
            sideColor: primary,
            padding: EdgeInsets.only(bottom: 16.0),
          ),
          OptionTile(
            title: "Cetak Transaksi",
            subtitle: "Mencetak semua transaksi (hutang & piutang) Zeffry Reynando",
            icon: Icons.picture_as_pdf,
            sideColor: secondaryLight,
            padding: EdgeInsets.only(bottom: 16.0),
          ),
        ],
      ),
    );
  }
}
