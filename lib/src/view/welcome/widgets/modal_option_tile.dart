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
            onTap: () => context.pushNamed(formNewTransactionRouteNamed),
            title: "Catat Piutang / Hutang",
            subtitle: "Mencatat transaksi piutang / hutang kamu.",
            icon: Icons.add_outlined,
            sideColor: Colors.green,
            padding: const EdgeInsets.only(bottom: 16.0),
          ),
          const OptionTile(
            title: "Tambah Orang",
            subtitle: "Menambahkan daftar orang yang ingin dipinjami atau meminjami",
            icon: Icons.people_outline,
            sideColor: Colors.deepOrange,
            padding: EdgeInsets.only(bottom: 16.0),
          ),
        ],
      ),
    );
  }
}
