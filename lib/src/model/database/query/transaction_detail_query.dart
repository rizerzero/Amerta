import 'package:drift/drift.dart';

import '../../../utils/shared_function.dart';
import '../../model/people/people_model.dart';
import '../../model/transaction_detail/transaction_detail_form_parameter.dart';
import '../../model/transaction_detail/transaction_detail_model.dart';
import '../../model/transaction_detail/transaction_detail_summary_model.dart';
import '../config_database.dart';

class TransactionDetailTableQuery extends MyDatabase {
  Future<TransactionDetailSummaryModel?> getTransactionDetailSummary({
    required String peopleId,
    required String transactionId,
  }) async {
    final query = customSelect(
      """
      SELECT
        t1.`id` AS ppl_id,
        t1.`name` AS ppl_name,
        t1.`image_path` AS ppl_image,
        t2.`id` AS trx_id,
        t2.`title` AS trx_title,
        t2.`loan_date` AS trx_loan_date,
        t2.`return_date` AS trx_return_date,
        (SELECT SUM(amount) FROM ${transactionDetailTable.tableName} WHERE `transaction_id` = t2.id) AS current_total_payment
      FROM
        ${peoplesTable.tableName} AS t1
        JOIN ${transactionTable.tableName} AS t2
          ON (t1.`id` = t2.`people_id`)
      WHERE t1.id = ?
        AND t2.`id` = ?
""",
      readsFrom: {
        peoplesTable,
        transactionTable,
        transactionDetailTable,
      },
      variables: [
        Variable.withString(peopleId),
        Variable.withString(transactionId),
      ],
    );

    final result = await query
        .map(
          (row) => TransactionDetailSummaryModel(
            people: PeopleModel(
              peopleId: row.read("ppl_id"),
              name: row.read("ppl_name"),
              imagePath: row.read("ppl_image"),
            ),
            transactionId: row.read("trx_id"),
            title: row.read("trx_title"),
            loanDate: fn.dateTimeFromUnix(row.read("trx_loan_date"))!,
            returnDate: fn.dateTimeFromUnix(row.read("trx_return_date")),
            currentTotalPayment: row.read<int?>("current_total_payment"),
          ),
        )
        .getSingleOrNull();
    return result;
  }

  Future<List<TransactionDetailModel>> getTransactionsDetail(String transactionId) async {
    final query = select(transactionDetailTable)
      ..where((trx) => trx.transactionId.equals(transactionId));
    final result = await query
        .map(
          (row) => TransactionDetailModel(
            amount: row.amount,
            attachmentPath: row.attachmentPath,
            createdAt: row.createdAt,
            description: row.description,
            id: row.id,
            transactionId: row.transactionId,
            updatedAt: row.updatedAt,
            peopleId: row.peopleId,
            date: row.date,
          ),
        )
        .get();

    return result;
  }

  Future<int> insertOrUpdateTransactionDetail(TransactionDetailFormParameter form) async {
    final query = await into(transactionDetailTable).insertOnConflictUpdate(
      TransactionDetailTableCompanion.insert(
        attachmentPath: Value(form.transaction.attachmentPath),
        amount: form.transaction.amount,
        date: form.transaction.date,
        createdAt: form.transaction.createdAt,
        description: Value(form.transaction.description),
        id: Value(form.transaction.id),
        peopleId: Value(form.transaction.peopleId),
        transactionId: Value(form.transaction.transactionId),
        updatedAt: Value(form.transaction.updatedAt),
      ),
    );

    return query;
  }

  Future<int> deleteTransactionDetail(String id) async {
    final query = delete(peoplesTable)..where((trx) => trx.id.equals(id));
    final result = await query.go();
    return result;
  }
}
