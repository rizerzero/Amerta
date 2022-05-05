import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../model/model/people/form_people_parameter.dart';
import '../../model/model/transaction/form_transaction_parameter.dart';
import '../../model/model/transaction_detail/form_transaction_detail_parameter.dart';
import '../../utils/utils.dart';

final formPeopleParameter = StateProvider.autoDispose(
  (ref) => FormPeopleParameter(
    id: const Uuid().v4(),
    name: '',
    createdAt: DateTime.now(),
  ),
);

final formTransactionParameter = StateProvider.autoDispose((ref) {
  return FormTransactionParameter(
    transactionId: const Uuid().v4(),
    loanDate: DateTime.now(),
    paymentStatus: PaymentStatus.notPaidOff,
    transactionType: TransactionType.piutang,
    createdAt: DateTime.now(),
  );
});

final formTransactionDetailParameter =
    StateProvider.autoDispose<FormTransactionDetailParameter>((ref) {
  return FormTransactionDetailParameter(
    id: const Uuid().v4(),
    transactionId: "",
    peopleId: "",
    amount: 0,
    date: DateTime.now(),
    createdAt: DateTime.now(),
  );
});
