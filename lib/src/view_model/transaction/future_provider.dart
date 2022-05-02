import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../model/model/people/people_model.dart';
import '../../model/model/transaction/recent_transaction_model.dart';
import '../../model/model/transaction/recent_transaction_parameter.dart';
import '../../model/model/transaction/summary_transaction_model.dart';

final getRecentTransaction = FutureProvider.autoDispose
    .family<List<RecentTransactionModel>, RecentTransactionParameter>((ref, param) async {
  final result = await ref.watch(transactionRepository).getRecentTransaction(
        type: param.type,
        limit: param.limit,
        peopleId: param.peopleId,
      );

  return result.getOrElse(() => []);
});

final getMySummaryTransaction = FutureProvider.autoDispose((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  final result = await ref.watch(transactionRepository).getSummaryTransaction(null);
  return result.getOrElse(() => const SummaryTransactionModel(people: PeopleModel()));
});

final getPeopleSummaryTransaction =
    FutureProvider.autoDispose.family<SummaryTransactionModel, String>((ref, peopleId) async {
  await Future.delayed(const Duration(seconds: 1));
  final result = await ref.watch(transactionRepository).getSummaryTransaction(peopleId);
  return result.getOrElse(() => const SummaryTransactionModel(people: PeopleModel()));
});
