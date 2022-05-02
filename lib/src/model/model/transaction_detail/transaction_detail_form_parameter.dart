import 'package:equatable/equatable.dart';

import 'transaction_detail_model.dart';

class TransactionDetailFormParameter extends Equatable {
  const TransactionDetailFormParameter({
    required this.transaction,
  });
  final TransactionDetailModel transaction;

  @override
  List<Object> get props => [transaction];

  @override
  String toString() => 'TransactionDetailFormParameter(transaction: $transaction)';

  TransactionDetailFormParameter copyWith({
    TransactionDetailModel? transaction,
  }) {
    return TransactionDetailFormParameter(
      transaction: transaction ?? this.transaction,
    );
  }
}
