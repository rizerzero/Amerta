import 'package:equatable/equatable.dart';

import '../../../utils/enums.dart';

class SummaryTransactionModel extends Equatable {
  const SummaryTransactionModel({
    required this.transactionType,
    required this.totalAmount,
    required this.totalAmountPayment,
  });

  final TransactionType? transactionType;
  final int? totalAmount;
  final int? totalAmountPayment;

  int get balance => (totalAmount ?? 0) - (totalAmountPayment ?? 0);

  @override
  List<Object?> get props => [transactionType, totalAmount, totalAmountPayment];

  @override
  String toString() =>
      'SummaryTransactionModel(transactionType: $transactionType, totalAmount: $totalAmount, totalAmountPayment: $totalAmountPayment)';

  SummaryTransactionModel copyWith({
    TransactionType? transactionType,
    int? totalAmount,
    int? totalAmountPayment,
  }) {
    return SummaryTransactionModel(
      transactionType: transactionType ?? this.transactionType,
      totalAmount: totalAmount ?? this.totalAmount,
      totalAmountPayment: totalAmountPayment ?? this.totalAmountPayment,
    );
  }
}
