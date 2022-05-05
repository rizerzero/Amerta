import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection.dart';
import '../../../model/model/transaction/summary_transaction_model.dart';
import '../../../utils/utils.dart';
import '../../widgets/modal_error.dart';
import '../../widgets/modal_loading.dart';

class ModalRemovePeople extends ConsumerWidget {
  const ModalRemovePeople({
    Key? key,
    required this.data,
  }) : super(key: key);

  final SummaryTransactionModel data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(peopleActionNotifier.select((value) => value.deleteAsync), (_, state) {
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
              title: "Berhasil menghapus ${data.people.name}",
            );

            context.goNamed(appRouteNamed);
          },
          error: (error, trace) => showDialog(
            context: context,
            builder: (context) => ModalErrorWidget(message: "$error"),
          ),
        );
      }
    });

    return AlertDialog(
      title: Text("Konfirmasi Hapus", style: bodyFont.copyWith(color: Colors.red)),
      content: Builder(
        builder: (context) {
          return SizedBox(
            width: 300,
            height: 100,
            child: Text(
              "Menghapus profile ${data.people.name} akan ikut menghapus semua history transaksi beserta detailnya",
              style: bodyFont.copyWith(fontSize: 16.0, color: grey),
              textAlign: TextAlign.justify,
            ),
          );
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () async =>
              await ref.read(peopleActionNotifier.notifier).delete(data.people.peopleId),
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
    );
  }
}
