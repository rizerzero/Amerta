import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model/transaction/transaction_model.dart';
import '../../model/repository/transaction_repository.dart';

part 'transaction_state.dart';

class TransactionNotifier extends StateNotifier<TransactionState> {
  TransactionNotifier({
    required this.repository,
    required this.id,
  }) : super(const TransactionState()) {
    getById(id);
  }

  final TransactionRepository repository;
  final String? id;
  Future<TransactionState> getById(String? transactionId) async {
    state = state.copyWith(item: const AsyncLoading());
    final result = await repository.getById(transactionId);

    return result.fold(
      (l) => state = state.copyWith(item: AsyncError(l.message)),
      (r) => state = state.copyWith(item: AsyncData(r)),
    );
  }
}
