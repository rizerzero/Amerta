import 'package:equatable/equatable.dart';

import '../../../utils/utils.dart';

class PrintTransactionParameter extends Equatable {
  const PrintTransactionParameter({
    required this.peopleId,
    this.printTransactionType = PrintTransactionType.hutangDanPiutang,
    this.paymentStatus,
  });

  final String peopleId;
  final PrintTransactionType printTransactionType;
  final PaymentStatus? paymentStatus;

  @override
  List<Object?> get props => [peopleId, printTransactionType, paymentStatus];

  @override
  String toString() =>
      'PrintTransactionParameter(peopleId: $peopleId, printTransactionType: $printTransactionType, paymentStatus: $paymentStatus)';

  PrintTransactionParameter copyWith({
    String? peopleId,
    PrintTransactionType? printTransactionType,
    PaymentStatus? paymentStatus,
  }) {
    return PrintTransactionParameter(
      peopleId: peopleId ?? this.peopleId,
      printTransactionType: printTransactionType ?? this.printTransactionType,
      paymentStatus: paymentStatus ?? this.paymentStatus,
    );
  }
}
