import 'package:drift/drift.dart';

import '../../../utils/shared_function.dart';
import '../../model/people/people_model.dart';
import '../../model/transaction_detail/form_transaction_detail_parameter.dart';
import '../../model/transaction_detail/transaction_detail_insertorupdate_response.dart';
import '../../model/transaction_detail/transaction_detail_model.dart';
import '../../model/transaction_detail/transaction_detail_summary_model.dart';
import '../config_database.dart';

class TransactionDetailTableQuery extends MyDatabase {
  Future<TransactionDetailModel?> getById(String? id) async {
    if (id == null) return null;

    final query = select(transactionDetailTable)..where((trx) => trx.id.equals(id));

    final result = await query
        .map(
          (row) async => TransactionDetailModel(
            id: row.id,
            amount: row.amount,
            attachmentPath: row.attachmentPath,
            description: row.description,
            peopleId: row.peopleId,
            createdAt: row.createdAt,
            date: row.date,
            transactionId: row.transactionId,
            updatedAt: row.updatedAt,
          ),
        )
        .getSingleOrNull();

    return result;
  }

  Future<TransactionDetailSummaryModel?> getTransactionDetailSummary({
    required String peopleId,
    required String transactionId,
  }) async {
    final query = """
      SELECT
        t1.`id` AS ppl_id,
        t1.`name` AS ppl_name,
        t1.`image_path` AS ppl_image,
        t1.`created_at` AS ppl_created_at,
        t1.`updated_at` AS ppl_updated_at,
        t2.`id` AS trx_id,
        t2.`title` AS trx_title,
        t2.`amount` as trx_amount,
        t2.`loan_date` AS trx_loan_date,
        t2.`return_date` AS trx_return_date,
        (SELECT SUM(amount) FROM ${transactionDetailTable.tableName} WHERE `transaction_id` = t2.id) AS amount_payment
      FROM
        ${peoplesTable.tableName} AS t1
        JOIN ${transactionTable.tableName} AS t2
          ON (t1.`id` = t2.`people_id`)
      WHERE t1.id = ?
        AND t2.`id` = ?
    """;
    final result = customSelect(query, readsFrom: {
      peoplesTable,
      transactionTable,
      transactionDetailTable,
    }, variables: [
      Variable.withString(peopleId),
      Variable.withString(transactionId),
    ]).map(
      (row) {
        return TransactionDetailSummaryModel(
          people: PeopleModel(
            peopleId: row.read("ppl_id"),
            name: row.read("ppl_name"),
            imagePath: row.read("ppl_image"),
          ),
          transactionId: row.read("trx_id"),
          title: row.read("trx_title"),
          loanDate: fn.dateTimeFromUnix(row.read("trx_loan_date"))!,
          returnDate: fn.dateTimeFromUnix(row.read("trx_return_date")),
          amountPayment: row.read<int?>("amount_payment"),
          amount: row.read("trx_amount"),
        );
      },
    ).getSingleOrNull();

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

  Future<TransactionDetailInsertOrUpdateResponse> insertOrUpdateTransactionDetail(
      FormTransactionDetailParameter form) async {
    final trx = await (select(transactionDetailTable)..where((t) => t.id.equals(form.id)))
        .getSingleOrNull();

    await transaction(() async {
      await into(transactionDetailTable).insertOnConflictUpdate(
        TransactionDetailTableCompanion.insert(
          id: Value(form.id),
          peopleId: Value(form.peopleId),
          transactionId: Value(form.transactionId),
          date: DateTime(form.date.year, form.date.month, form.date.day),
          amount: form.amount,
          attachmentPath: Value(form.attachment?.path),
          description: Value(form.description),
          createdAt: form.createdAt,
          updatedAt: Value(form.updatedAt),
        ),
      );
    });

    if (trx == null) {
      return TransactionDetailInsertOrUpdateResponse(
          isNewTransactionDetail: true,
          message: "Berhasil membuat detail transaksi dengan kode ${form.id}");
    }
    return TransactionDetailInsertOrUpdateResponse(
      isNewTransactionDetail: false,
      message: "Berhasil mengupdate detail transaksi dengan kode ${form.id}",
    );
  }

  Future<int> deleteTransactionDetail(String id) async {
    final query = delete(transactionDetailTable)..where((trx) => trx.id.equals(id));
    final result = await query.go();
    return result;
  }
}
