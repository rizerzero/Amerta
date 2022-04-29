import 'dart:developer';

import 'package:flutter/material.dart';

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
            title: "Tambah Piutang",
            subtitle: "Kamu ingin memberikan / meminjami uang kamu",
            icon: Icons.money_off_outlined,
            sideColor: Colors.green,
            margin: const EdgeInsets.only(bottom: 16.0),
            onTap: () {
              log("tes");
            },
          ),
          const OptionTile(
            title: "Tambah Hutang",
            subtitle: "Kamu ingin meminjam uang dari seseorang",
            icon: Icons.handshake_outlined,
            sideColor: Colors.deepOrange,
            margin: EdgeInsets.only(bottom: 16.0),
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
