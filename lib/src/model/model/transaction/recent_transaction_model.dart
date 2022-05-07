import 'package:equatable/equatable.dart';

import '../../../utils/utils.dart';
import '../people/people_model.dart';

class RecentTransactionModel extends Equatable {
  final String transactionId;
  final String title;
  final int amount;
  final int? amountPayment;
  final DateTime loanDate;
  final DateTime? returnDate;
  final TransactionType type;
  final PaymentStatus paymentStatus;
  final String? description;
  final PeopleModel people;

  const RecentTransactionModel({
    required this.transactionId,
    required this.title,
    required this.amount,
    required this.amountPayment,
    required this.loanDate,
    required this.returnDate,
    required this.type,
    required this.paymentStatus,
    required this.description,
    required this.people,
  });

  @override
  List<Object?> get props {
    return [
      transactionId,
      title,
      amount,
      amountPayment,
      loanDate,
      returnDate,
      type,
      paymentStatus,
      description,
      people,
    ];
  }

  @override
  String toString() {
    return 'RecentTransactionModel(transactionId: $transactionId, title: $title, amount: $amount, amountPayment: $amountPayment, loanDate: $loanDate, returnDate: $returnDate, type: $type, paymentStatus: $paymentStatus, description: $description, people: $people)';
  }

  RecentTransactionModel copyWith({
    String? transactionId,
    String? title,
    int? amount,
    int? amountPayment,
    DateTime? loanDate,
    DateTime? returnDate,
    TransactionType? type,
    PaymentStatus? paymentStatus,
    String? description,
    PeopleModel? people,
  }) {
    return RecentTransactionModel(
      transactionId: transactionId ?? this.transactionId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      amountPayment: amountPayment ?? this.amountPayment,
      loanDate: loanDate ?? this.loanDate,
      returnDate: returnDate ?? this.returnDate,
      type: type ?? this.type,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      description: description ?? this.description,
      people: people ?? this.people,
    );
  }
}
