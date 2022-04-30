import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';
import 'option_tile.dart';

class ModalOptionTile extends StatelessWidget {
  const ModalOptionTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OptionTile(
            title: "Catat Piutang / Hutang",
            subtitle: "Mencatat transaksi piutang / hutang kamu.",
            icon: Icons.money_off_outlined,
            sideColor: Colors.green,
            margin: const EdgeInsets.only(bottom: 16.0),
            onTap: () {
              context.pushNamed(formNewTransactionRouteNamed);
            },
          ),
          const OptionTile(
            title: "Tambah Orang",
            subtitle: "Menambahkan daftar orang yang ingin dipinjami atau meminjami",
            icon: Icons.people_outline,
            sideColor: primary,
            margin: EdgeInsets.only(bottom: 16.0),
          ),
        ],
      ),
    );
  }
}
