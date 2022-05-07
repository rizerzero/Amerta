import 'package:equatable/equatable.dart';

import '../../../utils/utils.dart';
import '../people/people_model.dart';

class PrintTransactionParameter extends Equatable {
  const PrintTransactionParameter({
    this.people = const PeopleModel(),
    this.printTransactionType = PrintTransactionType.hutangDanPiutang,
    this.paymentStatus,
  });

  final PeopleModel people;
  final PrintTransactionType printTransactionType;
  final PaymentStatus? paymentStatus;

  @override
  List<Object?> get props => [people, printTransactionType, paymentStatus];

  @override
  String toString() =>
      'PrintTransactionParameter(people: $people, printTransactionType: $printTransactionType, paymentStatus: $paymentStatus)';

  PrintTransactionParameter copyWith({
    PeopleModel? people,
    PrintTransactionType? printTransactionType,
    PaymentStatus? paymentStatus,
  }) {
    return PrintTransactionParameter(
      people: people ?? this.people,
      printTransactionType: printTransactionType ?? this.printTransactionType,
      paymentStatus: paymentStatus ?? this.paymentStatus,
    );
  }
}
