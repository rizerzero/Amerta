import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../utils/utils.dart';
import '../../widgets/modal_error.dart';
import '../../widgets/modal_loading.dart';

class ModalRemoveTransaction extends ConsumerWidget {
  const ModalRemoveTransaction({
    Key? key,
    required this.transactionId,
  }) : super(key: key);

  final String transactionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(transactionActionNotifier.select((value) => value.delete), (_, state) {
      if (state is AsyncLoading) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const ModalLoadingWidget(),
        );
      } else {
        /// Close Modal Loading
        Navigator.pop(context);

        state.whenOrNull(
          data: (_) {
            fn.showSnackbar(
              context,
              color: Colors.green,
              title: "Berhasil menghapus transaksi dengan kode $transactionId",
            );

            /// Close modal confirmation delete & modal bottom sheet option
            int count = 0;
            Navigator.popUntil(context, (route) => count++ == 2);
          },
          error: (error, trace) => showDialog(
            context: context,
            builder: (context) => ModalErrorWidget(message: "$error"),
          ),
        );
      }
    });

    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: Text("Konfirmasi Hapus", style: bodyFont.copyWith(color: Colors.red)),
        content: Builder(
          builder: (context) {
            return SizedBox(
              width: 300,
              height: 100,
              child: Text(
                "Menghapus transaksi akan menghilangkan history pembayaran di dalamnya.",
                style: bodyFont.copyWith(fontSize: 16.0, color: grey),
                textAlign: TextAlign.justify,
              ),
            );
          },
        ),
        actions: [
          ElevatedButton(
            onPressed: () async =>
                await ref.read(transactionActionNotifier.notifier).deleteTransaction(transactionId),
            style: ElevatedButton.styleFrom(primary: Colors.red),
            child: Text("Hapus", style: bodyFontWhite),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Batal",
              style: bodyFont.copyWith(color: grey),
            ),
          ),
        ],
      ),
    );
  }
}
