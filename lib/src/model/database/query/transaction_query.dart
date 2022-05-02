import 'package:drift/drift.dart';

import '../../../utils/utils.dart';
import '../../model/people/people_model.dart';
import '../../model/transaction/recent_transaction_model.dart';
import '../../model/transaction/summary_transaction_model.dart';
import '../../model/transaction/transaction_form_parameter.dart';
import '../config_database.dart';

class TransactionTableQuery extends MyDatabase {
  ///* [Transaction Section]

  Future<SummaryTransactionModel> getSummaryTransaction(String? peopleId) async {
    String where = "";

    if (peopleId == null) where = "WHERE t1.people_id = $peopleId";

    var query = customSelect(
      """                     
          SELECT 
          COALESCE(SUM(CASE WHEN t1.`transaction_type` = 'piutang' THEN t1.amount ELSE 0 END),0) AS total_piutang,
          COALESCE(SUM(CASE WHEN t1.`transaction_type` = 'hutang' THEN t1.amount ELSE 0 END),0) AS total_hutang,             
          t2.id AS people_id,
          t2.`name`,
          t2.`image_path`,
          t2.`created_at`,
          t2.`updated_at`
          FROM ${transactionTable.tableName} AS t1
          JOIN ${peoplesTable.tableName} AS t2 ON (t1.`people_id` = t2.`id`)
          $where
          """,
      readsFrom: {
        transactionTable,
        peoplesTable,
      },
    );

    final result = await query
        .map(
          (row) => SummaryTransactionModel(
            people: PeopleModel(
              peopleId: row.read("people_id") ?? '',
              name: row.read("name") ?? '',
              imagePath: row.read<String?>("image_path"),
              createdAt: fn.dateTimeFromUnix(row.read<int?>("created_at")),
              updatedAt: fn.dateTimeFromUnix(row.read<int?>("updated_at")),
            ),
            totalPiutang: row.read("total_piutang"),
            totalHutang: row.read("total_hutang"),
          ),
        )
        .getSingle();

    return result;
  }

  Future<List<RecentTransactionModel>> getRecentTransaction({
    required TransactionType type,
    String? peopleId,
    int? limit,
  }) async {
    String where = "WHERE t1.transaction_type = ?";
    String qLimit = "";

    if (peopleId != null) where += " AND t1.people_id = ? ";
    if (limit != null) qLimit += "LIMIT $limit";

    var query = customSelect(
      """
                              SELECT t1.id, t1.title, t1.amount, t1.transaction_type,
                              t1.id as people_id, t2.name,
                              (SELECT SUM(amount) FROM ${transactionDetailTable.tableName} WHERE transaction_id = t1.id ) as current_amount

                              FROM ${transactionTable.tableName} as t1
                              JOIN ${peoplesTable.tableName} as t2 ON (t2.id = t1.people_id)
                              $where $qLimit
                              """,
      variables: [
        Variable.withString(type.toStr()),
        if (peopleId != null) Variable.withString(peopleId),
        if (limit != null) Variable.withInt(limit),
      ],
      readsFrom: {
        transactionTable,
        peoplesTable,
      },
    );

    final result = await query
        .map(
          (row) => RecentTransactionModel.fromQueryRow(row),
        )
        .get();
    return result;
  }

  Future<int> insertOrUpdateTransaction(TransactionFormParameter form) async {
    final query = await into(transactionTable).insertOnConflictUpdate(
      TransactionTableCompanion(
        amount: Value(form.transaction.amount),
        attachmentPath: Value(form.transaction.attachmentPath),
        createdAt: Value(form.transaction.createdAt),
        description: Value(form.transaction.description),
        id: Value(form.transaction.id),
        loanDate: Value(form.transaction.loanDate),
        paymentStatus: Value(form.transaction.status.toStr()),
        peopleId: Value(form.transaction.peopleId),
        returnDate: Value(form.transaction.returnDate),
        title: Value(form.transaction.title),
        transactionType: Value(form.transaction.type.toStr()),
        updatedAt: Value(form.transaction.updatedAt),
      ),
    );

    return query;
  }

  Future<int> deleteTransaction(String id) async {
    final query = delete(transactionTable)..where((trx) => trx.id.equals(id));
    final result = await query.go();
    return result;
  }
}
