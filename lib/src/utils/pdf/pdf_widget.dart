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
    final _formatDate = DateFormat.yMMMMEEEEd().format(dateNow);
    final _formatTime = DateFormat.Hms().format(dateNow);

    const _scaffoldColor = PdfColor.fromInt(0xFFF0FAFF);
    const _primaryColor = PdfColor.fromInt(0xFF3DB2FF);

    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
      decoration: const pw.BoxDecoration(color: _scaffoldColor),
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
                        color: _primaryColor,
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
                        text: "$_formatDate $_formatTime",
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
    const _primaryColor = PdfColor.fromInt(0xFF3DB2FF);

    return pw.Container(
      margin: const pw.EdgeInsets.all(16.0),
      width: double.infinity,
      padding: const pw.EdgeInsets.all(16.0),
      decoration: pw.BoxDecoration(
        color: _primaryColor,
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
              fontSize: 16.0,
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
    const _primaryColor = PdfColor.fromInt(0xFF3DB2FF);
    const _secondaryDarkColor = PdfColor.fromInt(0xFF006A61);

    final totalPayment = payments.fold<int>(
      0,
      (previousValue, element) => previousValue + element.amount,
    );
    final remainingPayment = amount - totalPayment;
    return pw.Padding(
      padding: const pw.EdgeInsets.all(16.0),
      child: pw.Table(
        columnWidths: {
          0: const pw.FlexColumnWidth(1),
          1: const pw.FlexColumnWidth(6),
          2: const pw.FlexColumnWidth(5),
        },
        children: [
          pw.TableRow(
            decoration: pw.BoxDecoration(color: _primaryColor.shade(.4)),
            children: [
              pw.Column(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Text(
                      "No",
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              pw.Column(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Text(
                      "Deskripsi",
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              pw.Column(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Text(
                      "Nominal",
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          for (int j = 0; j < payments.length; j++)
            pw.TableRow(
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(color: PdfColors.grey800),
                ),
              ),
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8.0),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.SizedBox(height: 8.0),
                      pw.Text(
                        "${j + 1}",
                        textAlign: pw.TextAlign.center,
                        style: const pw.TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8.0),
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                    children: [
                      pw.SizedBox(height: 8.0),
                      pw.Builder(builder: (context) {
                        final _formatDate = DateFormat.yMMMMEEEEd().format(payments[j].createdAt!);
                        final _formatTime = DateFormat.Hms().format(payments[j].createdAt!);
                        return pw.Text(
                          "$_formatDate $_formatTime",
                          style: const pw.TextStyle(
                            fontSize: 12.0,
                          ),
                        );
                      }),
                      pw.SizedBox(height: 8.0),
                      pw.Text(
                        "${payments[j].description}",
                        style: const pw.TextStyle(
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8.0),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.SizedBox(height: 8.0),
                      pw.Text(
                        fn.rupiahCurrency(payments[j].amount),
                        textAlign: pw.TextAlign.right,
                        style: const pw.TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          pw.TableRow(
            decoration: const pw.BoxDecoration(
              color: _secondaryDarkColor,
              border: pw.Border(
                bottom: pw.BorderSide(color: PdfColors.grey800),
              ),
            ),
            children: [
              pw.SizedBox(),
              pw.Padding(
                padding: const pw.EdgeInsets.all(16.0),
                child: pw.Text(
                  "Total Pembayaran",
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(16.0),
                child: pw.Text(
                  fn.rupiahCurrency(totalPayment),
                  textAlign: pw.TextAlign.right,
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
          pw.TableRow(
            decoration: const pw.BoxDecoration(
              color: _secondaryDarkColor,
              border: pw.Border(
                bottom: pw.BorderSide(color: PdfColors.grey800),
              ),
            ),
            children: [
              pw.SizedBox(),
              pw.Padding(
                padding: const pw.EdgeInsets.all(16.0),
                child: pw.Text(
                  "Sisa Pembayaran",
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(16.0),
                child: pw.Text(
                  fn.rupiahCurrency(remainingPayment),
                  textAlign: pw.TextAlign.right,
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
