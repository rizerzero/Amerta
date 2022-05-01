import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/utils.dart';

class RecentTransactionModel extends Equatable {
  final String transactionId;
  final String peopleId;
  final String title;
  final TransactionType type;
  final int amount;
  final int currentAmount;

  const RecentTransactionModel({
    this.transactionId = '',
    this.peopleId = '',
    this.title = '',
    this.type = TransactionType.hutang,
    this.amount = 0,
    this.currentAmount = 0,
  });

  factory RecentTransactionModel.fromQueryRow(QueryRow row) {
    return RecentTransactionModel(
      amount: row.read<int>("amount"),
      currentAmount: row.read<int>("current_amount"),
      peopleId: row.read("people_id"),
      title: row.read("title"),
      transactionId: row.read("id"),
      type: TransactionType.values.byName(row.read<String>("transaction_type")),
    );
  }

  @override
  List<Object> get props {
    return [
      transactionId,
      peopleId,
      title,
      type,
      amount,
      currentAmount,
    ];
  }

  @override
  String toString() {
    return 'RecentTransactionModel(transactionId: $transactionId, peopleId: $peopleId, title: $title, type: $type, amount: $amount, currentAmount: $currentAmount)';
  }

  RecentTransactionModel copyWith({
    String? transactionId,
    String? peopleId,
    String? title,
    TransactionType? type,
    int? amount,
    int? currentAmount,
  }) {
    return RecentTransactionModel(
      transactionId: transactionId ?? this.transactionId,
      peopleId: peopleId ?? this.peopleId,
      title: title ?? this.title,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      currentAmount: currentAmount ?? this.currentAmount,
    );
  }
}
