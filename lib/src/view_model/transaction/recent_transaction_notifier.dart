import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../model/model/transaction/recent_transaction_model.dart';
import '../../model/model/transaction/recent_transaction_parameter.dart';
import '../payment/payment_action_notifier.dart';
import 'transaction_action_notifier.dart';

final getTransactions = FutureProvider.autoDispose
    .family<List<RecentTransactionModel>, RecentTransactionParameter>((ref, param) async {
  /// Every [add / update / delete] payment, refresh this provider
  ref.listen<PaymentActionState>(paymentActionNotifier, (_, state) {
    state.insertOrUpdate.whenData((_) => ref.invalidateSelf());
    state.delete.whenData((_) => ref.invalidateSelf());
  });

  /// Every [add / update / delete] transaction, refresh this provider
  ref.listen<TransactionActionState>(transactionActionNotifier, (_, state) {
    state.insertOrUpdate.whenData((_) => ref.invalidateSelf());
    state.delete.whenData((_) => ref.invalidateSelf());
  });

  final result = await ref.watch(transactionRepository).getTransactions(
        type: param.type,
        limit: param.limit,
        peopleId: param.peopleId,
        paymentStatus: param.paymentStatus,
      );

  return result.getOrElse(() => []);
});
