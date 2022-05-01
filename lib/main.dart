import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/app.dart';
import 'src/model/model/people/people_model.dart';
import 'src/model/model/transaction/transaction_model.dart';
import 'src/model/model/transaction_detail/transaction_detail_model.dart';
import 'src/utils/utils.dart';

/// Hive Type List :
/// 1. People Model
/// 2. Transaction Model
/// 3. TransactionType Enum
/// 4. PaymentStatus Enum
/// 5. TransactionDetail Model

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await initHive();

  // turn off the # in the URLs on the web
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  runApp(const ProviderScope(child: App()));
}

Future<void> initHive() async {
  Hive.registerAdapter(PeopleModelAdapter());
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());
  Hive.registerAdapter(PaymentStatusAdapter());
  Hive.registerAdapter(TransactionDetailModelAdapter());

  await Hive.openBox<PeopleModel>(kHivePeopleBox);
  await Hive.openBox<List<TransactionModel>>(kHiveTransactionBox);
  await Hive.openBox<List<TransactionDetailModel>>(kHiveTransactionDetailBox);
}
