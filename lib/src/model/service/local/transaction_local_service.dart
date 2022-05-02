import '../../../utils/enums.dart';
import '../../database/query/transaction_query.dart';
import '../../model/transaction/recent_transaction_model.dart';
import '../../model/transaction/summary_transaction_model.dart';
import '../../model/transaction/transaction_form_parameter.dart';

class TransactionLocalService {
  const TransactionLocalService({
    required this.query,
  });

  final TransactionTableQuery query;

  Future<SummaryTransactionModel> getSummaryTransaction(String? peopleId) async {
    final result = await query.getSummaryTransaction(peopleId);
    return result;
  }

  Future<List<RecentTransactionModel>> getRecentTransaction({
    required TransactionType type,
    String? peopleId,
    int? limit,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    final result = await query.getRecentTransaction(
      type: type,
      limit: limit,
      peopleId: peopleId,
    );
    return result;
  }

  Future<int> insertOrUpdateTransaction(TransactionFormParameter form) async {
    final result = await query.insertOrUpdateTransaction(form);
    return result;
  }

  Future<int> deleteTransaction(String id) async {
    final result = query.deleteTransaction(id);
    return result;
  }
}
