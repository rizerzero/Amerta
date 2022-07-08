import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../model/model/transaction/summary_transaction_model.dart';
import '../payment/payment_action_notifier.dart';
import '../transaction/transaction_action_notifier.dart';

final getPeopleSummaryTransactionById =
    FutureProvider.autoDispose.family<SummaryTransactionModel, String?>((ref, peopleId) async {
  /// Setiap ada aksi dari [paymentActionNotifier]
  /// Refresh provider ini
  ref.listen<PaymentActionState>(paymentActionNotifier, (previous, next) {
    next.delete.whenData((value) => ref.invalidateSelf());
    next.insertOrUpdate.whenData((value) => ref.invalidateSelf());
  });

  /// Setiap ada aksi dari [transactionActionNotifier]
  /// Refresh provider ini
  ref.listen<TransactionActionState>(transactionActionNotifier, (previous, next) {
    next.delete.whenData((value) => ref.invalidateSelf());
    next.insertOrUpdate.whenData((value) => ref.invalidateSelf());
  });

  final repository = ref.watch(transactionRepository);
  final result = await repository.getSummaryTransaction(peopleId);
  return result.fold((l) => throw l.message, (summaryTransaction) => summaryTransaction);
});
