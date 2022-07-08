import 'package:equatable/equatable.dart';

import '../../../utils/enums.dart';

class TransactionParameter extends Equatable {
  const TransactionParameter({
    required this.type,
    this.limit,
    this.peopleId,
    this.paymentStatus,
  });

  final TransactionType type;
  final int? limit;
  final String? peopleId;
  final PaymentStatus? paymentStatus;

  @override
  List<Object?> get props => [type, limit, peopleId, paymentStatus];

  @override
  String toString() {
    return 'TransactionParameter(type: $type, limit: $limit, peopleId: $peopleId, paymentStatus: $paymentStatus)';
  }

  TransactionParameter copyWith({
    TransactionType? type,
    int? limit,
    String? peopleId,
    PaymentStatus? paymentStatus,
  }) {
    return TransactionParameter(
      type: type ?? this.type,
      limit: limit ?? this.limit,
      peopleId: peopleId ?? this.peopleId,
      paymentStatus: paymentStatus ?? this.paymentStatus,
    );
  }
}
