import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../model/model/transaction_detail/transaction_detail_model.dart';
import '../../model/model/transaction_detail/transaction_detail_summary_model.dart';
import '../../model/model/transaction_detail/transaction_detail_summary_parameter.dart';

final getTransactionDetailSummary = FutureProvider.autoDispose
    .family<TransactionDetailSummaryModel?, TransactionDetailSummaryParameter>((ref, param) async {
  final result = await ref.watch(transactionDetailRepository).getTransactionDetailSummary(
        peopleId: param.peopleId,
        transactionId: param.transactionId,
      );

  return result.getOrElse(() => null);
});

final getTransactionsDetail =
    FutureProvider.autoDispose.family<Map<DateTime, List<TransactionDetailModel>>, String>(
  (ref, transactionId) async {
    final result =
        await ref.watch(transactionDetailRepository).getTransactionsDetail(transactionId);

    return result.getOrElse(() => {});
  },
);
