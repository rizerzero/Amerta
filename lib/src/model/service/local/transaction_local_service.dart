import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
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

  Future<List<SummaryTransactionModel>> getSummaryTransaction(String? peopleId) async {
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
    final pdf = pw.Document(author: kDeveloper, creator: kDeveloper);
    final pdfWidget = PDFWidget();

    final themeData = pw.ThemeData.withFont(base: await PdfGoogleFonts.aBeeZeeRegular());

    final isHutangAndPiutang =
        parameter.printTransactionType == PrintTransactionType.hutangDanPiutang;

    /// Get list all transaction depend of [type, peopleId, paymentStatus]
    Future<List<RecentTransactionModel>> _transcations(PrintTransactionParameter parameter) async {
      List<RecentTransactionModel> transactions = [];

      if (isHutangAndPiutang) {
        final hutang = await query.getTransactions(
          type: TransactionType.hutang,
          peopleId: parameter.peopleId,
          paymentStatus: parameter.paymentStatus,
        );
        final piutang = await query.getTransactions(
          type: TransactionType.piutang,
          peopleId: parameter.peopleId,
          paymentStatus: parameter.paymentStatus,
        );
        transactions = [...hutang, ...piutang];
      } else {
        final _items = await query.getTransactions(
          type: parameter.printTransactionType.toTransactionType(),
          peopleId: parameter.peopleId,
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

    final transactionGroupBy =
        groupBy<RecentTransactionModel, TransactionType>(items, (key) => key.type);

    for (final entry in transactionGroupBy.entries) {
      final key = entry.key;
      final values = entry.value;
      final header = await pdfWidget.builderHeader(
        transactionType: key,
        name: items.first.people.name,
      );

      pdf.addPage(
        pw.MultiPage(
          theme: themeData,
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.only(),
          header: (context) => header,
          build: (context) {
            return [
              for (int index = 0; index < values.length; index++) ...[
                pdfWidget.information(index: index, item: values[index]),
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

                  return pdfWidget.historyPaymentTable(
                    amount: values[index].amount,
                    payments: peoplePayments!,
                  );
                }),
              ]
            ];
          },
        ),
      );
    }

    final byte = await pdf.save();

    return byte;
  }
}
