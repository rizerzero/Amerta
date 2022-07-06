import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../model/model/payment/payment_model.dart';
import '../../model/model/transaction/recent_transaction_model.dart';
import '../utils.dart';

class PDFWidget {
  Future<pw.Widget> builderHeader({
    required TransactionType transactionType,
    required String name,
  }) async {
    final logoByte = await rootBundle.load("assets/images/logo.png");
    final logo = pw.MemoryImage(logoByte.buffer.asUint8List());

    final dateNow = DateTime.now();
    final formatDate = DateFormat.yMMMMEEEEd().format(dateNow);
    final formatTime = DateFormat.Hms().format(dateNow);

    const scaffoldColor = PdfColor.fromInt(0xFFF0FAFF);
    const primaryColor = PdfColor.fromInt(0xFF3DB2FF);

    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
      decoration: const pw.BoxDecoration(color: scaffoldColor),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Expanded(
            child: pw.SizedBox(
              width: double.infinity,
              child: pw.Align(
                alignment: pw.Alignment.topLeft,
                child: pw.ClipRRect(
                  horizontalRadius: 8,
                  verticalRadius: 8,
                  child: pw.Image(
                    logo,
                    height: 80,
                    width: 80,
                  ),
                ),
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.SizedBox(
                  height: 40,
                  child: pw.FittedBox(
                    fit: pw.BoxFit.contain,
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      transactionType.name.toUpperCase(),
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                pw.SizedBox(height: 16.0),
                pw.RichText(
                  text: pw.TextSpan(
                    style: const pw.TextStyle(fontSize: 16.0),
                    text: "Kepada :\n",
                    children: [
                      pw.TextSpan(
                        text: name,
                        style: const pw.TextStyle(color: PdfColors.grey600),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 8.0),
                pw.RichText(
                  text: pw.TextSpan(
                    style: const pw.TextStyle(fontSize: 16.0),
                    text: "Dibuat :\n",
                    children: [
                      pw.TextSpan(
                        text: "$formatDate $formatTime",
                        style: const pw.TextStyle(color: PdfColors.grey600),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 8.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget information({
    required int index,
    required RecentTransactionModel item,
  }) {
    const primaryColor = PdfColor.fromInt(0xFF3DB2FF);

    return pw.Container(
      margin: const pw.EdgeInsets.all(16.0),
      width: double.infinity,
      padding: const pw.EdgeInsets.all(16.0),
      decoration: pw.BoxDecoration(
        color: primaryColor,
        borderRadius: pw.BorderRadius.circular(8.0),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          pw.Row(
            children: [
              pw.Text(
                "${index + 1}. ",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.white,
                  fontSize: 20.0,
                ),
              ),
              pw.Text(
                "#${item.transactionId}",
                style: pw.TextStyle(
                  color: PdfColors.white.shade(.4),
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 16.0),
          pw.Text(
            "${item.title} ",
            style: pw.TextStyle(
              color: PdfColors.white.shade(.4),
              fontSize: 20.0,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 16.0),
          pw.Row(
            children: [
              pw.Text(
                DateFormat.yMMMMEEEEd().format(item.loanDate),
                style: const pw.TextStyle(
                  fontSize: 16.0,
                  color: PdfColors.white,
                ),
              ),
              pw.Text(" - ", style: const pw.TextStyle(color: PdfColors.white)),
              pw.Text(
                fn.isNullOrEmpty(item.returnDate)
                    ? "Tidak ditentukan"
                    : DateFormat.yMMMMEEEEd().format(item.returnDate!),
                style: const pw.TextStyle(
                  fontSize: 16.0,
                  color: PdfColors.white,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 16.0),
          pw.Text(
            "${item.description ?? "Tidak ada deskripsi"} ",
            style: pw.TextStyle(
              color: PdfColors.white.shade(.4),
              fontSize: 12.0,
            ),
          ),
          pw.SizedBox(height: 8.0),
          pw.Text(
            fn.rupiahCurrency(item.amount),
            textAlign: pw.TextAlign.right,
            style: pw.TextStyle(
              color: PdfColors.white,
              fontSize: 32.0,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 8.0),
        ],
      ),
    );
  }

  pw.Widget historyPaymentTable({
    required int amount,
    required List<PaymentModel> payments,
  }) {
    const primaryColor = PdfColor.fromInt(0xFF3DB2FF);
    const secondaryDarkColor = PdfColor.fromInt(0xFF006A61);

    final totalPayment = payments.fold<int>(
      0,
      (previousValue, element) => previousValue + element.amount,
    );
    final remainingPayment = amount - totalPayment;
    return pw.Padding(
      padding: const pw.EdgeInsets.all(16.0),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            decoration: const pw.BoxDecoration(color: primaryColor),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    "No",
                    style: const pw.TextStyle(color: PdfColors.white),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.Expanded(
                  flex: 6,
                  child: pw.Text(
                    "Deskripsi",
                    style: const pw.TextStyle(color: PdfColors.white),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.Expanded(
                  flex: 5,
                  child: pw.Text(
                    "Nominal",
                    style: const pw.TextStyle(color: PdfColors.white),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < payments.length; i++)
            pw.Container(
              padding: const pw.EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(color: PdfColors.grey400),
                ),
              ),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      "${i + 1}",
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Expanded(
                    flex: 6,
                    child: pw.Builder(builder: (context) {
                      final payment = payments[i];
                      final formatDate = DateFormat.yMMMMEEEEd().format(payment.createdAt!);
                      final formatTime = DateFormat.Hms().format(payment.createdAt!);
                      final description = payment.description;
                      return pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                        children: [
                          pw.Text(
                            "$formatDate $formatTime",
                            textAlign: pw.TextAlign.left,
                          ),
                          if (description != null || (description?.isNotEmpty ?? false)) ...[
                            pw.SizedBox(height: 4.0),
                            pw.Text(
                              "$description",
                              textAlign: pw.TextAlign.left,
                              style: const pw.TextStyle(
                                fontSize: 10.0,
                                color: PdfColors.grey800,
                              ),
                            ),
                          ],
                        ],
                      );
                    }),
                  ),
                  pw.Expanded(
                    flex: 5,
                    child: pw.Text(
                      fn.rupiahCurrency(payments[i].amount),
                      textAlign: pw.TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            decoration: const pw.BoxDecoration(color: secondaryDarkColor),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Expanded(
                  flex: 8,
                  child: pw.Text(
                    "Total Pembayaran",
                    style: const pw.TextStyle(color: PdfColors.white),
                    textAlign: pw.TextAlign.right,
                  ),
                ),
                pw.Expanded(
                  flex: 4,
                  child: pw.Text(
                    fn.rupiahCurrency(totalPayment),
                    style: pw.TextStyle(
                      color: PdfColors.white,
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 16.0,
                    ),
                    textAlign: pw.TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            decoration: const pw.BoxDecoration(color: secondaryDarkColor),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Expanded(
                  flex: 8,
                  child: pw.Text(
                    "Sisa Pembayaran",
                    style: const pw.TextStyle(color: PdfColors.white),
                    textAlign: pw.TextAlign.right,
                  ),
                ),
                pw.Expanded(
                  flex: 4,
                  child: pw.Text(
                    fn.rupiahCurrency(remainingPayment),
                    style: pw.TextStyle(
                      color: PdfColors.white,
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 16.0,
                    ),
                    textAlign: pw.TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
