import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../model/model/transaction/transaction_model.dart';

final getTransactionById =
    FutureProvider.autoDispose.family<TransactionModel?, String?>((ref, id) async {
  final repository = ref.watch(transactionRepository);
  final result = await repository.getById(id);
  return result.fold((failure) => throw failure.message, (transaction) => transaction);
});
