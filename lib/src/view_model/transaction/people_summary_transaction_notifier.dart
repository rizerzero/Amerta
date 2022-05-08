import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model/transaction/summary_transaction_model.dart';
import '../../model/repository/transaction_repository.dart';
import '../../utils/utils.dart';

part 'people_summary_transaction_state.dart';

class PeopleSummaryTransactionNotifier extends StateNotifier<PeopleSummaryTransactionState> {
  PeopleSummaryTransactionNotifier({
    required this.repository,
    required this.peopleId,
  }) : super(const PeopleSummaryTransactionState()) {
    getSummaryTransaction(peopleId);
  }

  final TransactionRepository repository;
  final String? peopleId;

  Future<PeopleSummaryTransactionState> getSummaryTransaction(String? peopleId) async {
    state = state.copyWith(items: const AsyncLoading());
    final result = await repository.getSummaryTransaction(peopleId);
    return result.fold(
      (l) => state = state.copyWith(items: AsyncError(l.message)),
      (r) => state = state.copyWith(items: AsyncData(r)),
    );
  }
}
