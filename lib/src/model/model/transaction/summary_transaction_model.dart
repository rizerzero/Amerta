import 'package:equatable/equatable.dart';

import 'summary_transaction_detail_model.dart';

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
