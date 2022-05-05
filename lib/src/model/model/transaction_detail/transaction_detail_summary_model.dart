import 'package:equatable/equatable.dart';

import '../people/people_model.dart';

class TransactionDetailSummaryModel extends Equatable {
  const TransactionDetailSummaryModel({
    required this.people,
    required this.transactionId,
    required this.amountPayment,
    required this.title,
    required this.amount,
    required this.loanDate,
    this.returnDate,
  });

  final PeopleModel people;
  final String transactionId;
  final int? amountPayment;
  final String title;
  final int amount;
  final DateTime loanDate;
  final DateTime? returnDate;

  @override
  List<Object?> get props {
    return [
      people,
      transactionId,
      amountPayment,
      title,
      amount,
      loanDate,
      returnDate,
    ];
  }

  @override
  String toString() {
    return 'TransactionDetailSummaryModel(people: $people, transactionId: $transactionId, amountPayment: $amountPayment, title: $title, amount: $amount, loanDate: $loanDate, returnDate: $returnDate)';
  }

  TransactionDetailSummaryModel copyWith({
    PeopleModel? people,
    String? transactionId,
    int? amountPayment,
    String? title,
    int? amount,
    DateTime? loanDate,
    DateTime? returnDate,
  }) {
    return TransactionDetailSummaryModel(
      people: people ?? this.people,
      transactionId: transactionId ?? this.transactionId,
      amountPayment: amountPayment ?? this.amountPayment,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      loanDate: loanDate ?? this.loanDate,
      returnDate: returnDate ?? this.returnDate,
    );
  }
}
