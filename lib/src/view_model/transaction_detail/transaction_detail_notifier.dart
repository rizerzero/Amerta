import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model/transaction_detail/transaction_detail_model.dart';
import '../../model/repository/transaction_detail_repository.dart';

part 'transaction_detail_state.dart';

class TransactionDetailNotifier extends StateNotifier<TransactionDetailState> {
  TransactionDetailNotifier({
    required this.repository,
    required this.id,
  }) : super(const TransactionDetailState()) {
    getById(id);
  }

  final TransactionDetailRepository repository;
  final String? id;

  Future<TransactionDetailState> getById(String? id) async {
    state = state.copyWith(item: const AsyncLoading());
    final result = await repository.getById(id);
    return result.fold(
      (l) => state = state.copyWith(item: AsyncError(l.message)),
      (r) => state = state.copyWith(item: AsyncData(r)),
    );
  }
}
