import 'package:equatable/equatable.dart';

class PaymentSummaryParameter extends Equatable {
  const PaymentSummaryParameter({
    this.peopleId = '',
    this.transactionId = '',
  });

  final String peopleId;
  final String transactionId;

  @override
  List<Object> get props => [peopleId, transactionId];

  @override
  String toString() =>
      'PaymentSummaryParameter(peopleId: $peopleId, transactionId: $transactionId)';

  PaymentSummaryParameter copyWith({
    String? peopleId,
    String? transactionId,
  }) {
    return PaymentSummaryParameter(
      peopleId: peopleId ?? this.peopleId,
      transactionId: transactionId ?? this.transactionId,
    );
  }
}
