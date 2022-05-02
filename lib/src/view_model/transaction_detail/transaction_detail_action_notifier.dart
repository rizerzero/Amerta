import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model/transaction_detail/transaction_detail_form_parameter.dart';
import '../../model/repository/transaction_detail_repository.dart';

part 'transaction_detail_action_state.dart';

class TransactionDetailActionNotifier extends StateNotifier<TransactionDetailActionState> {
  TransactionDetailActionNotifier({required this.repository})
      : super(const TransactionDetailActionState());

  final TransactionDetailRepository repository;

  Future<TransactionDetailActionState> insertOrUpdateTransactionDetail(
    TransactionDetailFormParameter form,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(insertOrUpdate: const AsyncLoading());
    final result = await repository.insertOrUpdateTransactionDetail(form);
    return result.fold(
      (failure) => state = state.copyWith(insertOrUpdate: AsyncError(failure.message)),
      (val) => state = state.copyWith(insertOrUpdate: const AsyncData(null)),
    );
  }

  Future<TransactionDetailActionState> deleteTransactionDetail(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(delete: const AsyncLoading());
    final result = await repository.deleteTransactionDetail(id);
    return result.fold(
      (failure) => state = state.copyWith(delete: AsyncError(failure.message)),
      (val) => state = state.copyWith(delete: const AsyncData(null)),
    );
  }
}
