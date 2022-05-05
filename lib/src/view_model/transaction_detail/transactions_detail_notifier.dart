import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../model/model/transaction_detail/transaction_detail_model.dart';
import 'transaction_detail_action_notifier.dart';

final getTransactionsDetail =
    FutureProvider.autoDispose.family<Map<DateTime, List<TransactionDetailModel>>, String>(
  (ref, transactionId) async {
    /// Every [add / update / delete] transaction detail, refresh this provider
    ref.listen<TransactionDetailActionState>(transactionDetailActionNotifier, (_, state) {
      state.insertOrUpdate.whenData((_) => ref.invalidateSelf());
      state.delete.whenData((_) => ref.invalidateSelf());
    });

    final result =
        await ref.watch(transactionDetailRepository).getTransactionsDetail(transactionId);

    return result.getOrElse(() => {});
  },
);
