import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../model/model/transaction/print_transaction_parameter.dart';
import '../../model/repository/transaction_repository.dart';

part 'print_transaction_state.dart';

class PrintTransactionNotifier extends StateNotifier<PrintTransactionState> {
  PrintTransactionNotifier({
    required this.repository,
  }) : super(const PrintTransactionState());

  final TransactionRepository repository;

  Future<PrintTransactionState> printTransaction(PrintTransactionParameter parameter) async {
    state = state.copyWith(item: const AsyncLoading());
    final result = await repository.printTransaction(parameter);
    return result.fold(
      (l) => state = state.copyWith(item: AsyncError(l.message)),
      (r) => state = state.copyWith(item: AsyncData(r)),
    );
  }
}

final printTransactionNotifier =
    StateNotifierProvider.autoDispose<PrintTransactionNotifier, PrintTransactionState>(
  (ref) {
    return PrintTransactionNotifier(repository: ref.watch(transactionRepository));
  },
);
