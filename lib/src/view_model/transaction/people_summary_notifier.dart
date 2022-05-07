import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../model/model/people/people_model.dart';
import '../../model/model/transaction/summary_transaction_model.dart';
import '../people/people_action_notifier.dart';
import 'transaction_action_notifier.dart';

final getPeopleSummaryTransaction =
    FutureProvider.autoDispose.family<SummaryTransactionModel, String?>((ref, peopleId) async {
  /// Every [update] people, refresh this provider
  ref.listen<PeopleActionState>(peopleActionNotifier, (_, state) {
    state.insertOrUpdateAsync
        .whenData((response) => response!.isNewPeople ? null : ref.invalidateSelf());
  });

  /// Every [add / update / delete] transaction, refresh this provider
  ref.listen<TransactionActionState>(transactionActionNotifier, (_, state) {
    state.insertOrUpdate.whenData((_) => ref.invalidateSelf());
    state.delete.whenData((_) => ref.invalidateSelf());
  });

  final result = await ref.watch(transactionRepository).getSummaryTransaction(peopleId);
  return result.getOrElse(() => const SummaryTransactionModel(people: PeopleModel()));
});
