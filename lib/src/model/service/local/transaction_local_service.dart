import 'package:flutter/material.dart';

import '../../../utils/enums.dart';
import '../../database/query/transaction_query.dart';
import '../../model/transaction/form_transaction_parameter.dart';
import '../../model/transaction/recent_transaction_model.dart';
import '../../model/transaction/summary_transaction_model.dart';
import '../../model/transaction/transaction_insertorupdate_response.dart';
import '../../model/transaction/transaction_model.dart';

class TransactionLocalService {
  const TransactionLocalService({
    required this.query,
  });

  final TransactionTableQuery query;

  Future<SummaryTransactionModel> getSummaryTransaction(String? peopleId) async {
    await Future.delayed(kThemeAnimationDuration);
    final result = await query.getSummaryTransaction(peopleId);
    return result;
  }

  Future<List<RecentTransactionModel>> getRecentTransaction({
    required TransactionType type,
    String? peopleId,
    int? limit,
  }) async {
    await Future.delayed(kThemeAnimationDuration);
    final result = await query.getRecentTransaction(
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
}
