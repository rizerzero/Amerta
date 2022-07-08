import 'package:equatable/equatable.dart';

import '../../../utils/utils.dart';

class SummaryTransactionModel extends Equatable {
  const SummaryTransactionModel({
    required this.hutang,
    required this.piutang,
  });

  final SummaryTransactionDetailModel hutang;
  final SummaryTransactionDetailModel piutang;

  @override
  List<Object> get props => [hutang, piutang];

  @override
  String toString() => 'SummaryTransactionModel(hutang: $hutang, piutang: $piutang)';

  SummaryTransactionModel copyWith({
    SummaryTransactionDetailModel? hutang,
    SummaryTransactionDetailModel? piutang,
  }) {
    return SummaryTransactionModel(
      hutang: hutang ?? this.hutang,
      piutang: piutang ?? this.piutang,
    );
  }
}

class SummaryTransactionDetailModel extends Equatable {
  const SummaryTransactionDetailModel({
    required this.transactionType,
    this.totalAmount = 0.0,
    this.totalAmountPayment = 0.0,
    this.balance = 0.0,
  });

  final TransactionType transactionType;
  final double totalAmount;
  final double totalAmountPayment;
  // Accumulate from [$totalAmount - $totalAmountPayment]
  final double balance;

  @override
  List<Object> get props => [transactionType, totalAmount, totalAmountPayment, balance];

  @override
  String toString() {
    return 'SummaryTransactionDetailModel(transactionType: $transactionType, totalAmount: $totalAmount, totalAmountPayment: $totalAmountPayment, balance: $balance)';
  }

  SummaryTransactionDetailModel copyWith({
    TransactionType? transactionType,
    double? totalAmount,
    double? totalAmountPayment,
    double? balance,
  }) {
    return SummaryTransactionDetailModel(
      transactionType: transactionType ?? this.transactionType,
      totalAmount: totalAmount ?? this.totalAmount,
      totalAmountPayment: totalAmountPayment ?? this.totalAmountPayment,
      balance: balance ?? this.balance,
    );
  }
}
