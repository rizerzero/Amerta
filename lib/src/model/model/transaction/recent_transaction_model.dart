import 'package:equatable/equatable.dart';

import '../../../utils/utils.dart';
import '../people/people_model.dart';

class RecentTransactionModel extends Equatable {
  final String transactionId;
  final String title;
  final TransactionType type;
  final int amount;
  final int? amountPayment;
  final PeopleModel people;

  const RecentTransactionModel({
    required this.transactionId,
    required this.title,
    required this.type,
    required this.amount,
    required this.amountPayment,
    required this.people,
  });

  @override
  List<Object?> get props {
    return [
      transactionId,
      title,
      type,
      amount,
      amountPayment,
      people,
    ];
  }

  @override
  String toString() {
    return 'RecentTransactionModel(transactionId: $transactionId, title: $title, type: $type, amount: $amount, amountPayment: $amountPayment, people: $people)';
  }

  RecentTransactionModel copyWith({
    String? transactionId,
    String? title,
    TransactionType? type,
    int? amount,
    int? amountPayment,
    PeopleModel? people,
  }) {
    return RecentTransactionModel(
      transactionId: transactionId ?? this.transactionId,
      title: title ?? this.title,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      amountPayment: amountPayment ?? this.amountPayment,
      people: people ?? this.people,
    );
  }
}
