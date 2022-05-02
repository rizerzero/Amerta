import 'package:collection/collection.dart';

import '../../database/query/transaction_detail_query.dart';
import '../../model/transaction_detail/transaction_detail_form_parameter.dart';
import '../../model/transaction_detail/transaction_detail_model.dart';
import '../../model/transaction_detail/transaction_detail_summary_model.dart';

class TransactionDetailLocalService {
  const TransactionDetailLocalService({
    required this.query,
  });

  final TransactionDetailTableQuery query;

  Future<TransactionDetailSummaryModel?> getTransactionDetailSummary({
    required String peopleId,
    required String transactionId,
  }) async {
    final result = await query.getTransactionDetailSummary(
      peopleId: peopleId,
      transactionId: transactionId,
    );
    return result;
  }

  Future<Map<DateTime, List<TransactionDetailModel>>> getTransactionsDetail(
    String transactionId,
  ) async {
    final result = await query.getTransactionsDetail(transactionId);
    final groupedList = groupBy<TransactionDetailModel, DateTime>(
      result,
      (trx) {
        final date = trx.date;
        return DateTime(date.year, date.month, date.day);
      },
    );

    return groupedList;
  }

  Future<int> insertOrUpdateTransactionDetail(TransactionDetailFormParameter form) async {
    final result = await query.insertOrUpdateTransactionDetail(form);
    return result;
  }

  Future<int> deleteTransactionDetail(String id) async {
    final result = await query.deleteTransactionDetail(id);
    return result;
  }
}
