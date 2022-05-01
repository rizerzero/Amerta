import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/utils.dart';

class ModalRemoveTransactionDetail extends StatelessWidget {
  const ModalRemoveTransactionDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Konfirmasi hapus",
        style: bodyFont.copyWith(color: Colors.red),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: "Kamu akan menghapus transaksi "),
                TextSpan(
                  text: "#${const Uuid().v4()}.",
                  style: bodyFont.copyWith(
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
                const TextSpan(
                  text: "\nAksi ini tidak dapat dikembalikan, apakah kamu yakin ?",
                ),
              ],
            ),
            style: bodyFont.copyWith(
              fontSize: 12.0,
              color: black,
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(primary: Colors.red),
          child: Text(
            "Hapus",
            style: bodyFontWhite.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Batal",
            style: bodyFont.copyWith(color: grey),
          ),
        ),
      ],
    );
  }
}
