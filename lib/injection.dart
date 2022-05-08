import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/model/database/query/payment_query.dart';
import 'src/model/database/query/people_query.dart';
import 'src/model/database/query/transaction_query.dart';
import 'src/model/repository/payment_repository.dart';
import 'src/model/repository/people_repository.dart';
import 'src/model/repository/transaction_repository.dart';
import 'src/model/service/local/payment_local_service.dart';
import 'src/model/service/local/people_local_service.dart';
import 'src/model/service/local/transaction_local_service.dart';
import 'src/view_model/payment/payment_action_notifier.dart';
import 'src/view_model/payment/payment_notifier.dart';
import 'src/view_model/people/people_action_notifier.dart';
import 'src/view_model/people/people_notifier.dart';
import 'src/view_model/people/peoples_summary_notifier.dart';
import 'src/view_model/transaction/people_summary_transaction_notifier.dart';
import 'src/view_model/transaction/print_transaction_notifier.dart';
import 'src/view_model/transaction/transaction_action_notifier.dart';
import 'src/view_model/transaction/transaction_notifier.dart';

///* [Payment Section]

final paymentLocalService = Provider(
  (ref) => PaymentLocalService(query: ref.watch(paymentTableQuery)),
);

final paymentRepository = Provider(
  (ref) => PaymentRepository(localService: ref.watch(paymentLocalService)),
);

final paymentNotifier =
    StateNotifierProvider.autoDispose.family<PaymentNotifier, PaymentState, String?>((ref, id) {
  return PaymentNotifier(
    repository: ref.watch(paymentRepository),
    id: id,
  );
});

final paymentActionNotifier =
    StateNotifierProvider.autoDispose<PaymentActionNotifier, PaymentActionState>(
  (ref) => PaymentActionNotifier(repository: ref.watch(paymentRepository)),
);

///* [Transaction Section]

final transactionLocalService = Provider((ref) {
  return TransactionLocalService(
    query: ref.watch(transactionTableQuery),
    paymentQuery: ref.watch(paymentTableQuery),
  );
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

final peopleSummaryTransactionNotifier = StateNotifierProvider.autoDispose
    .family<PeopleSummaryTransactionNotifier, PeopleSummaryTransactionState, String?>(
  (ref, peopleId) {
    /// Every [add / update / delete] transaction, refresh this provider
    ref.listen<TransactionActionState>(transactionActionNotifier, (_, state) {
      state.insertOrUpdate.whenData((_) => ref.invalidateSelf());
      state.delete.whenData((_) => ref.invalidateSelf());
    });

    /// Every [add / update / delete] payment, refresh this provider
    ref.listen<PaymentActionState>(paymentActionNotifier, (_, state) {
      state.insertOrUpdate.whenData((_) => ref.invalidateSelf());
      state.delete.whenData((_) => ref.invalidateSelf());
    });

    return PeopleSummaryTransactionNotifier(
      peopleId: peopleId,
      repository: ref.watch(transactionRepository),
    );
  },
);

final printTransactionNotifier =
    StateNotifierProvider.autoDispose<PrintTransactionNotifier, PrintTransactionState>(
  (ref) {
    return PrintTransactionNotifier(repository: ref.watch(transactionRepository));
  },
);

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
  (ref, id) {
    return PeopleNotifier(
      repository: ref.watch(peopleRepository),
      peopleId: id,
    );
  },
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
final paymentTableQuery = Provider<PaymentTableQuery>((ref) => PaymentTableQuery());
