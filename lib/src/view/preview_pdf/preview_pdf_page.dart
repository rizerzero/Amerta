import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

import '../../view_model/transaction/print_transaction_notifier.dart';

class PreviewPdfPage extends ConsumerWidget {
  const PreviewPdfPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (context) {
          return PdfPreview(
            pdfFileName: "transaksi.pdf",
            canChangeOrientation: false,
            canChangePageFormat: false,
            allowPrinting: false,
            canDebug: false,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.download_outlined),
              )
            ],
            previewPageMargin: const EdgeInsets.only(bottom: 16.0),
            loadingWidget: const Center(child: CircularProgressIndicator()),
            build: (format) async {
              final byte = ref.read(printTransactionNotifier).item.value;

              if (byte == null) {
                throw "Terjadi masalah saat melakukan preview PDF, coba beberapa saat lagi...";
              }

              return byte;
            },
            onError: (context, error) => Center(child: Text("error $error")),
          );
        }),
      ),
    );
  }
}
