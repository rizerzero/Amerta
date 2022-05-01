import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/model/model/people/people_model.dart';
import 'src/model/model/transaction/transaction_model.dart';
import 'src/model/model/transaction_detail/transaction_detail_model.dart';
import 'src/model/service/local/people_local_service.dart';
import 'src/utils/utils.dart';

/// People Section

final peopleDetailNotifier = StateNotifierProvider<PeopleDetailNotifier, PeopleDetailState>(
  (ref) => PeopleDetailNotifier(peopleRepository: ref.watch(_peopleRepository)),
);

final peoplesNotifier = StateNotifierProvider<PeoplesNotifier, PeopleState>((ref) {
  return PeoplesNotifier(peopleRepository: ref.watch(_peopleRepository));
});
final _peopleRepository = Provider<PeopleRepository>((ref) {
  return PeopleRepositoryImplement(
    peopleLocalService: ref.watch(_peopleService),
  );
});
final _peopleService = Provider<PeopleLocalService>((ref) {
  return PeopleLocalService(peopleBox: ref.watch(_peopleBox));
});

final _peopleBox = Provider<Box<PeopleModel>>((ref) {
  return Hive.box<PeopleModel>(kHivePeopleBox);
});

final _transactionBox = Provider<Box<TransactionModel>>((ref) {
  return Hive.box<TransactionModel>(kHiveTransactionBox);
});

final _transactionDetailBox = Provider<Box<TransactionDetailModel>>((ref) {
  return Hive.box<TransactionDetailModel>(kHiveTransactionDetailBox);
});
