import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../utils/utils.dart';
import '../../database/query/payment_query.dart';
import '../../database/query/transaction_query.dart';
import '../../model/payment/payment_model.dart';
import '../../model/payment/payments_parameter.dart';
import '../../model/transaction/form_transaction_parameter.dart';
import '../../model/transaction/print_transaction_parameter.dart';
import '../../model/transaction/recent_transaction_model.dart';
import '../../model/transaction/summary_transaction_model.dart';
import '../../model/transaction/transaction_insertorupdate_response.dart';
import '../../model/transaction/transaction_model.dart';

class TransactionLocalService {
  const TransactionLocalService({
    required this.query,
    required this.paymentQuery,
  });

  final TransactionTableQuery query;
  final PaymentTableQuery paymentQuery;

  Future<SummaryTransactionModel> getSummaryTransaction(String? peopleId) async {
    await Future.delayed(kThemeAnimationDuration);
    final result = await query.getSummaryTransaction(peopleId);
    return result;
  }

  Future<List<RecentTransactionModel>> getTransactions({
    required TransactionType type,
    String? peopleId,
    int? limit,
    PaymentStatus? paymentStatus,
  }) async {
    await Future.delayed(kThemeAnimationDuration);
    final result = await query.getTransactions(
      type: type,
      limit: limit,
      peopleId: peopleId,
    );
    return result;
  }

  Future<TransactionModel?> getById(String? id) async {
    final result = await query.getById(id);
    return result;
  }

  Future<TransactionInsertOrUpdateResponse> insertOrUpdateTransaction(
      FormTransactionParameter form) async {
    await Future.delayed(kThemeAnimationDuration);
    final result = await query.insertOrUpdateTransaction(form);
    return result;
  }

  Future<int> deleteTransaction(String id) async {
    final result = query.deleteTransaction(id);
    return result;
  }

  Future<Uint8List> printTransaction(PrintTransactionParameter parameter) async {
    final logoByte = await rootBundle.load("assets/images/logo.png");
    final logo = pw.MemoryImage(logoByte.buffer.asUint8List());

    final pdf = pw.Document(author: kDeveloper, creator: kDeveloper);

    final themeData = pw.ThemeData.withFont(base: await PdfGoogleFonts.aBeeZeeRegular());

    const _primaryColor = PdfColor.fromInt(0xFF3DB2FF);
    const _secondaryDarkColor = PdfColor.fromInt(0xFF006A61);
    const _scaffoldColor = PdfColor.fromInt(0xFFF0FAFF);

    final dateNow = DateTime.now();
    final isHutangAndPiutang =
        parameter.printTransactionType == PrintTransactionType.hutangDanPiutang;

    /// Get list all transaction depend of [type, peopleId, paymentStatus]
    Future<List<RecentTransactionModel>> _transcations(PrintTransactionParameter parameter) async {
      List<RecentTransactionModel> transactions = [];

      if (isHutangAndPiutang) {
        final hutang = await query.getTransactions(
          type: TransactionType.hutang,
          peopleId: parameter.people.peopleId,
          paymentStatus: parameter.paymentStatus,
        );
        final piutang = await query.getTransactions(
          type: TransactionType.piutang,
          peopleId: parameter.people.peopleId,
          paymentStatus: parameter.paymentStatus,
        );
        transactions = [...hutang, ...piutang];
      } else {
        final _items = await query.getTransactions(
          type: parameter.printTransactionType.toTransactionType(),
          peopleId: parameter.people.peopleId,
          paymentStatus: parameter.paymentStatus,
        );

        transactions = [..._items];
      }

      return transactions;
    }

    /// Get list all payments depend of [transactionId]

    Future<Map<String, List<PaymentModel>>> _payments(
        List<RecentTransactionModel> transactions) async {
      if (transactions.isEmpty) return {};

      List<PaymentModel> payments = [];
      for (final transaction in transactions) {
        final items = await paymentQuery
            .getPayments(PaymentsParameter(transactionId: transaction.transactionId));
        payments = [...payments, ...items];
      }
      final grouped = groupBy<PaymentModel, String>(payments, (key) => key.transactionId);
      return grouped;
    }

    final items = await _transcations(parameter);
    if (items.isEmpty) throw Exception("Data transaksi tidak ditemukan");
    final payments = await _payments(items);

    pw.Widget _buildHeader(pw.Context context, TransactionType transactionType) {
      final _people = items.first.people;
      final _formatDate = DateFormat.yMMMMEEEEd().format(dateNow);
      final _formatTime = DateFormat.Hms().format(dateNow);
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
                          text: _people.name,
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

    final transactionGroupBy =
        groupBy<RecentTransactionModel, TransactionType>(items, (key) => key.type);

    for (final entry in transactionGroupBy.entries) {
      final key = entry.key;
      final values = entry.value;
      pdf.addPage(
        pw.MultiPage(
          theme: themeData,
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.only(),
          header: (context) => _buildHeader(context, key),
          build: (context) {
            return [
              for (int index = 0; index < values.length; index++) ...[
                pw.Container(
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
                            "#${values[index].transactionId}",
                            style: pw.TextStyle(
                              color: PdfColors.white.shade(.4),
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 16.0),
                      pw.Text(
                        "${values[index].title} ",
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
                            DateFormat.yMMMMEEEEd().format(values[index].loanDate),
                            style: const pw.TextStyle(
                              fontSize: 16.0,
                              color: PdfColors.white,
                            ),
                          ),
                          pw.Text(" - ", style: const pw.TextStyle(color: PdfColors.white)),
                          pw.Text(
                            fn.isNullOrEmpty(values[index].returnDate)
                                ? "Tidak ditentukan"
                                : DateFormat.yMMMMEEEEd().format(values[index].returnDate!),
                            style: const pw.TextStyle(
                              fontSize: 16.0,
                              color: PdfColors.white,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 16.0),
                      pw.Text(
                        "${values[index].description ?? "Tidak ada deskripsi"} ",
                        style: pw.TextStyle(
                          color: PdfColors.white.shade(.4),
                          fontSize: 12.0,
                        ),
                      ),
                      pw.SizedBox(height: 8.0),
                      pw.Text(
                        fn.rupiahCurrency(values[index].amount),
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
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(16.0),
                  child: pw.Text(
                    "Progress Pembayaran",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16.0),
                  ),
                ),
                pw.Builder(builder: (context) {
                  final peoplePayments = payments[values[index].transactionId];
                  final paymentIsEmpty = peoplePayments?.isEmpty ?? true;
                  if (paymentIsEmpty) {
                    return pw.Padding(
                      padding: const pw.EdgeInsets.all(16.0),
                      child: pw.Center(
                        child: pw.Text(
                          "Progress pembayaran tidak ditemukan",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }

                  final totalPayment = peoplePayments!.fold<int>(
                    0,
                    (previousValue, element) => previousValue + element.amount,
                  );
                  final remainingPayment = values[index].amount - totalPayment;
                  return pw.Padding(
                    padding: const pw.EdgeInsets.all(16.0),
                    child: pw.Table(
                      columnWidths: {
                        0: const pw.FlexColumnWidth(5),
                        1: const pw.FlexColumnWidth(5),
                        2: const pw.FlexColumnWidth(2),
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
                        for (int j = 0; j < peoplePayments.length; j++)
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
                                  mainAxisAlignment: pw.MainAxisAlignment.center,
                                  crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                                  children: [
                                    pw.SizedBox(height: 8.0),
                                    pw.Builder(builder: (context) {
                                      final _formatDate = DateFormat.yMMMMEEEEd()
                                          .format(peoplePayments[j].createdAt!);
                                      final _formatTime =
                                          DateFormat.Hms().format(peoplePayments[j].createdAt!);
                                      return pw.Text(
                                        "$_formatDate $_formatTime",
                                        style: const pw.TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      );
                                    }),
                                    pw.SizedBox(height: 8.0),
                                    pw.Text(
                                      "${peoplePayments[j].description}",
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
                                      fn.rupiahCurrency(peoplePayments[j].amount),
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
                }),
              ]
            ];
          },
        ),
      );
    }

    final byte = await pdf.save();
    await Future.delayed(const Duration(seconds: 1));

    return byte;
  }
}
