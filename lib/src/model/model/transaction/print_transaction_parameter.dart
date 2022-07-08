import 'package:equatable/equatable.dart';

import '../../../utils/utils.dart';

class PrintTransactionParameter extends Equatable {
  const PrintTransactionParameter({
    required this.transactionId,
    required this.peopleId,
    this.printTransactionType = PrintTransactionType.hutangDanPiutang,
    this.paymentStatus,
  });

  /// Parameter transaksi id digunakan ketika ingin [print single transaksi]
  final String? transactionId;

  final String peopleId;
  final PrintTransactionType printTransactionType;
  final PaymentStatus? paymentStatus;

  @override
  List<Object?> get props => [transactionId, peopleId, printTransactionType, paymentStatus];

  @override
  String toString() {
    return 'PrintTransactionParameter(transactionId: $transactionId, peopleId: $peopleId, printTransactionType: $printTransactionType, paymentStatus: $paymentStatus)';
  }

  PrintTransactionParameter copyWith({
    String? transactionId,
    String? peopleId,
    PrintTransactionType? printTransactionType,
    PaymentStatus? paymentStatus,
  }) {
    return PrintTransactionParameter(
      transactionId: transactionId ?? this.transactionId,
      peopleId: peopleId ?? this.peopleId,
      printTransactionType: printTransactionType ?? this.printTransactionType,
      paymentStatus: paymentStatus ?? this.paymentStatus,
    );
  }
}
