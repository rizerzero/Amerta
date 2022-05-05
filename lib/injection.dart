import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/model/database/query/people_query.dart';
import 'src/model/database/query/transaction_detail_query.dart';
import 'src/model/database/query/transaction_query.dart';
import 'src/model/repository/people_repository.dart';
import 'src/model/repository/transaction_detail_repository.dart';
import 'src/model/repository/transaction_repository.dart';
import 'src/model/service/local/people_local_service.dart';
import 'src/model/service/local/transaction_detail_local_service.dart';
import 'src/model/service/local/transaction_local_service.dart';
import 'src/view_model/people/people_action_notifier.dart';
import 'src/view_model/people/people_notifier.dart';
import 'src/view_model/people/peoples_summary_notifier.dart';
import 'src/view_model/transaction/transaction_action_notifier.dart';
import 'src/view_model/transaction/transaction_notifier.dart';
import 'src/view_model/transaction_detail/transaction_detail_action_notifier.dart';
import 'src/view_model/transaction_detail/transaction_detail_notifier.dart';

///* [Transaction Detail Section]

final transactionDetailLocalService = Provider(
  (ref) => TransactionDetailLocalService(query: ref.watch(transactionDetailTableQuery)),
);

final transactionDetailRepository = Provider(
  (ref) => TransactionDetailRepository(
      transactionDetailLocalService: ref.watch(transactionDetailLocalService)),
);

final transactionDetailNotifier = StateNotifierProvider.autoDispose
    .family<TransactionDetailNotifier, TransactionDetailState, String?>((ref, id) {
  return TransactionDetailNotifier(
    repository: ref.watch(transactionDetailRepository),
    id: id,
  );
});

final transactionDetailActionNotifier = StateNotifierProvider.autoDispose<
    TransactionDetailActionNotifier, TransactionDetailActionState>(
  (ref) => TransactionDetailActionNotifier(repository: ref.watch(transactionDetailRepository)),
);

///* [Transaction Section]

final transactionLocalService = Provider((ref) {
  return TransactionLocalService(query: ref.watch(transactionTableQuery));
});

final transactionRepository = Provider((ref) {
  return TransactionRepository(transactionLocalService: ref.watch(transactionLocalService));
});

final transactionActionNotifier =
    StateNotifierProvider.autoDispose<TransactionActionNotifier, TransactionActionState>((ref) {
  return TransactionActionNotifier(repository: ref.watch(transactionRepository));
});

final transactionNotifier = StateNotifierProvider.family
    .autoDispose<TransactionNotifier, TransactionState, String?>((ref, id) {
  return TransactionNotifier(
    repository: ref.watch(transactionRepository),
    id: id,
  );
});

///* [People Section]

final peopleLocalService = Provider<PeopleLocalService>(
  (ref) => PeopleLocalService(query: ref.watch(peopleTableQuery)),
);

final peopleRepository = Provider(
  (ref) => PeopleRepository(peopleLocalService: ref.watch(peopleLocalService)),
);

final peopleActionNotifier =
    StateNotifierProvider.autoDispose<PeopleActionNotifier, PeopleActionState>((ref) {
  return PeopleActionNotifier(ref.watch(peopleRepository));
});

final peopleNotifier =
    StateNotifierProvider.autoDispose.family<PeopleNotifier, PeopleState, String?>(
  (ref, id) => PeopleNotifier(
    repository: ref.watch(peopleRepository),
    peopleId: id,
  ),
);

final peoplesSummaryNotifier =
    StateNotifierProvider.autoDispose<PeoplesSummaryNotifier, PeoplesSummaryState>((ref) {
  return PeoplesSummaryNotifier(repository: ref.watch(peopleRepository));
});

///* [Query Section]
final peopleTableQuery = Provider<PeopleTableQuery>((ref) => PeopleTableQuery());
final transactionTableQuery = Provider<TransactionTableQuery>(
  (ref) => TransactionTableQuery(peopleQuery: ref.watch(peopleTableQuery)),
);
final transactionDetailTableQuery =
    Provider<TransactionDetailTableQuery>((ref) => TransactionDetailTableQuery());
