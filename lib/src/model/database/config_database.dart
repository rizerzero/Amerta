import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../model/people/people_model.dart';
import '../model/people/peoples_model.dart';
import '../model/transaction/recent_transaction_model.dart';

part 'table/transaction_table.dart';
part 'table/people_table.dart';
part 'table/transaction_detail_table.dart';

part 'config_database.g.dart';

@DriftDatabase(
  tables: [
    PeoplesTable,
    TransactionTable,
    TransactionDetailTable,
  ],
)
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  /// People Section
  Future<List<PeopleModel>> get10People() async {
    var query = select(peoplesTable);
    query.limit(10);
    final result = await query.map((row) => PeopleModel.fromJson(row.toColumns(true))).get();
    return result;
  }

  /// Transaction Section
  Future<List<RecentTransactionModel>> get10Transaction() async {
    var query = customSelect("""
                              SELECT t1.id, t1.title, t1.amount, t1.transaction_type,
                              t1.id as people_id, t2.name,
                              (SELECT SUM(amount) FROM ${transactionDetailTable.tableName} WHERE transaction_id = t1.id ) as current_amount

                              FROM ${transactionTable.tableName} as t1
                              JOIN ${peoplesTable.tableName} as t2 ON (t2.id = t1.people_id)
                              """);

    final result = await query
        .map(
          (row) => RecentTransactionModel.fromQueryRow(row),
        )
        .get();
    return result;
  }

  Future<List<PeoplesModel>> getUsers() async {
    final query = customSelect("""
    SELECT
      t1.*,
      COUNT(t2.id) AS total_transaksi,
      (SELECT
        COALESCE(SUM(amount),0)
      FROM
        ${transactionTable.tableName}
      WHERE `people_id` = t1.`id`
        AND `transaction_type` = 'hutang') AS totalHutang,
        (SELECT
        COALESCE(SUM(amount),0)
      FROM
        ${transactionTable.tableName}
      WHERE `people_id` = t1.`id`
        AND `transaction_type` = 'piutang') AS totalPiutang
    FROM
      ${peoplesTable.tableName} AS t1
      LEFT JOIN ${transactionTable.tableName} AS t2
        ON (t1.`id` = t2.people_id)
      LEFT JOIN ${transactionDetailTable.tableName} AS t3
        ON (t2.`id` = t3.transaction_id)
    GROUP BY t1.id
""");

    final result = await query.map((row) => PeoplesModel.fromQueryRow(row)).get();
    return result;
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
