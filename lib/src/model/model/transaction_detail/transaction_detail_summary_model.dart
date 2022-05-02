import 'package:equatable/equatable.dart';

import '../people/people_model.dart';

class TransactionDetailSummaryModel extends Equatable {
  final PeopleModel people;
  final int? currentTotalPayment;
  final String transactionId;
  final String title;
  final DateTime loanDate;
  final DateTime? returnDate;
  const TransactionDetailSummaryModel({
    required this.people,
    this.currentTotalPayment,
    this.transactionId = '',
    this.title = '',
    required this.loanDate,
    this.returnDate,
  });

  @override
  List<Object?> get props {
    return [
      people,
      currentTotalPayment,
      transactionId,
      title,
      loanDate,
      returnDate,
    ];
  }

  @override
  String toString() {
    return 'TransactionDetailSummaryModel(people: $people, currentTotalPayment: $currentTotalPayment, transactionId: $transactionId, title: $title, loanDate: $loanDate, returnDate: $returnDate)';
  }

  TransactionDetailSummaryModel copyWith({
    PeopleModel? people,
    int? currentTotalPayment,
    String? transactionId,
    String? title,
    DateTime? loanDate,
    DateTime? returnDate,
  }) {
    return TransactionDetailSummaryModel(
      people: people ?? this.people,
      currentTotalPayment: currentTotalPayment ?? this.currentTotalPayment,
      transactionId: transactionId ?? this.transactionId,
      title: title ?? this.title,
      loanDate: loanDate ?? this.loanDate,
      returnDate: returnDate ?? this.returnDate,
    );
  }
}
