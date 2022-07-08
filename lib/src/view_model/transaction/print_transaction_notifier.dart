import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model/transaction/print_transaction_parameter.dart';
import '../../model/repository/transaction_repository.dart';

part 'print_transaction_state.dart';

class PrintTransactionNotifier extends StateNotifier<PrintTransactionState> {
  PrintTransactionNotifier({
    required this.repository,
  }) : super(const PrintTransactionState());

  final TransactionRepository repository;

  Future<PrintTransactionState> printMultipleTransaction(
      PrintTransactionParameter parameter) async {
    state = state.copyWith(item: const AsyncLoading());
    final result = await repository.printMultipleTransaction(parameter);
    return result.fold(
      (failure) => state = state.copyWith(item: AsyncError(failure.message)),
      (bytes) => state = state.copyWith(item: AsyncData(bytes)),
    );
  }

  Future<PrintTransactionState> printSingleTransaction(PrintTransactionParameter parameter) async {
    state = state.copyWith(item: const AsyncLoading());
    final result = await repository.printSingleTransaction(parameter);
    return result.fold(
      (failure) => state = state.copyWith(item: AsyncError(failure.message)),
      (bytes) => state = state.copyWith(item: AsyncData(bytes)),
    );
  }
}
