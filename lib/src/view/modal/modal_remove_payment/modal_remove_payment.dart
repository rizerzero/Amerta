import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../injection.dart';
import '../../../utils/utils.dart';
import '../../widgets/modal_loading.dart';

class ModalRemovePayment extends ConsumerWidget {
  const ModalRemovePayment({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      paymentActionNotifier.select((value) => value.delete),
      (_, state) {
        if (state is AsyncLoading) {
          showDialog(
            context: context,
            builder: (context) => const ModalLoadingWidget(),
          );
        } else {
          state.whenOrNull(
            data: (data) {
              fn.showSnackbar(
                context,
                title: "Berhasil menghapus transaksi $id",
                color: Colors.green,
              );
            },
            error: (error, trace) {
              fn.showSnackbar(context, title: "$error", color: Colors.red);
            },
          );

          /// Tutup Modal Konfirmasi Delete & Loading
          int count = 0;
          Navigator.popUntil(context, (route) => count++ == 2);
        }
      },
    );

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
          onPressed: () async {
            await ref.read(paymentActionNotifier.notifier).deletePayment(id);
          },
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
