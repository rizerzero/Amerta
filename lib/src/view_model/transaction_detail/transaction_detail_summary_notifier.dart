import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../model/model/transaction_detail/transaction_detail_summary_model.dart';
import '../../model/model/transaction_detail/transaction_detail_summary_parameter.dart';
import 'transaction_detail_action_notifier.dart';

final getTransactionDetailSummary = FutureProvider.autoDispose
    .family<TransactionDetailSummaryModel?, TransactionDetailSummaryParameter>((ref, param) async {
  /// Every [add / update / delete] transaction detail, refresh this provider
  ref.listen<TransactionDetailActionState>(transactionDetailActionNotifier, (_, state) {
    state.insertOrUpdate.whenData((_) => ref.invalidateSelf());
    state.delete.whenData((_) => ref.invalidateSelf());
  });

  final result = await ref.watch(transactionDetailRepository).getTransactionDetailSummary(
        peopleId: param.peopleId,
        transactionId: param.transactionId,
      );

  return result.getOrElse(() => null);
});
