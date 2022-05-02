import 'package:equatable/equatable.dart';

import 'transaction_model.dart';

class TransactionFormParameter extends Equatable {
  final TransactionModel transaction;
  const TransactionFormParameter({
    required this.transaction,
  });

  @override
  List<Object> get props => [transaction];

  @override
  String toString() => 'TransactionFormParameter(transaction: $transaction)';

  TransactionFormParameter copyWith({
    TransactionModel? transaction,
  }) {
    return TransactionFormParameter(
      transaction: transaction ?? this.transaction,
    );
  }
}
