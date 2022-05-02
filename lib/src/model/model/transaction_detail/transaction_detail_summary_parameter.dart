import 'package:equatable/equatable.dart';

class TransactionDetailSummaryParameter extends Equatable {
  const TransactionDetailSummaryParameter({
    this.peopleId = '',
    this.transactionId = '',
  });

  final String peopleId;
  final String transactionId;

  @override
  List<Object> get props => [peopleId, transactionId];

  @override
  String toString() =>
      'TransactionDetailSummaryParameter(peopleId: $peopleId, transactionId: $transactionId)';

  TransactionDetailSummaryParameter copyWith({
    String? peopleId,
    String? transactionId,
  }) {
    return TransactionDetailSummaryParameter(
      peopleId: peopleId ?? this.peopleId,
      transactionId: transactionId ?? this.transactionId,
    );
  }
}
