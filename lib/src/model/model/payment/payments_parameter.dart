import 'package:equatable/equatable.dart';

class PaymentsParameter extends Equatable {
  const PaymentsParameter({
    this.transactionId,
    this.peopleId,
  });

  final String? transactionId;
  final String? peopleId;

  @override
  List<Object?> get props => [transactionId, peopleId];

  @override
  String toString() => 'PaymentsParameter(transactionId: $transactionId, peopleId: $peopleId)';

  PaymentsParameter copyWith({
    String? transactionId,
    String? peopleId,
  }) {
    return PaymentsParameter(
      transactionId: transactionId ?? this.transactionId,
      peopleId: peopleId ?? this.peopleId,
    );
  }
}
