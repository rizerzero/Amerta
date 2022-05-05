import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model/transaction/form_transaction_parameter.dart';
import '../../model/model/transaction/transaction_insertorupdate_response.dart';
import '../../model/repository/transaction_repository.dart';

part 'transaction_action_state.dart';

class TransactionActionNotifier extends StateNotifier<TransactionActionState> {
  TransactionActionNotifier({
    required this.repository,
  }) : super(const TransactionActionState());

  final TransactionRepository repository;

  Future<TransactionActionState> deleteTransaction(String id) async {
    state = state.copyWith(delete: const AsyncLoading());
    final result = await repository.deleteTransaction(id);
    return result.fold(
      (failure) => state = state.copyWith(delete: AsyncError(failure.message)),
      (val) => state = state.copyWith(delete: AsyncData(val)),
    );
  }

  Future<TransactionActionState> insertOrUpdateTransaction(FormTransactionParameter form) async {
    state = state.copyWith(insertOrUpdate: const AsyncLoading());
    final result = await repository.insertOrUpdateTransaction(form);
    return result.fold(
      (failure) => state = state.copyWith(insertOrUpdate: AsyncError(failure.message)),
      (val) => state = state.copyWith(insertOrUpdate: AsyncData(val)),
    );
  }
}
