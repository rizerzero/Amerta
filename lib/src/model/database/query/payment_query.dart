import 'package:drift/drift.dart';

import '../../../utils/utils.dart';
import '../../model/payment/form_payment_parameter.dart';
import '../../model/payment/payment_insertorupdate_response.dart';
import '../../model/payment/payment_model.dart';
import '../../model/payment/payment_summary_model.dart';
import '../../model/payment/payments_parameter.dart';
import '../../model/people/people_model.dart';
import '../../model/transaction/transaction_model.dart';
import '../my_database.dart';

class PaymentTableQuery extends MyDatabase {
  Future<PaymentModel?> getById(String? id) async {
    if (id == null) return null;

    final query = select(paymentTable)..where((payment) => payment.id.equals(id));

    final result = await query
        .map(
          (row) async => PaymentModel(
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

  Future<PaymentSummaryModel?> getPaymentSummary({
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
        (SELECT SUM(amount) FROM ${paymentTable.tableName} WHERE `transaction_id` = t2.id) AS amount_payment
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
      paymentTable,
    }, variables: [
      Variable.withString(peopleId),
      Variable.withString(transactionId),
    ]).map(
      (row) {
        return PaymentSummaryModel(
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

  Future<List<PaymentModel>> getPayments(PaymentsParameter param) async {
    final query = select(paymentTable).join(
      [
        innerJoin(
          transactionTable,
          transactionTable.id.equalsExp(paymentTable.transactionId),
        ),
      ],
    );

    if (param.transactionId != null) {
      query.where(paymentTable.transactionId.equals(param.transactionId));
    }

    if (param.peopleId != null) {
      query.where(paymentTable.peopleId.equals(param.peopleId));
    }

    final result = await query.map((row) {
      final transaction = row.readTable(transactionTable);
      final payment = row.readTable(paymentTable);
      return PaymentModel(
        id: payment.id,
        createdAt: payment.createdAt,
        date: payment.date,
        amount: payment.amount,
        updatedAt: payment.updatedAt,
        attachmentPath: payment.attachmentPath,
        description: payment.description,
        peopleId: payment.peopleId,
        transactionId: payment.transactionId,
        transaction: TransactionModel(
          id: transaction.id,
          amount: transaction.amount,
          attachmentPath: transaction.attachmentPath,
          description: transaction.description,
          peopleId: transaction.peopleId,
          updatedAt: transaction.updatedAt,
          returnDate: transaction.returnDate,
          status: PaymentStatus.values.byName(transaction.paymentStatus),
          title: transaction.title,
          type: TransactionType.values.byName(transaction.transactionType),
          loanDate: transaction.loanDate,
          createdAt: transaction.createdAt,
        ),
      );
    }).get();

    return result;
  }

  Future<PaymentInsertOrUpdateResponse> insertOrUpdatePayment(FormPaymentParameter form) async {
    final trx = await (select(paymentTable)..where((payment) => payment.id.equals(form.id)))
        .getSingleOrNull();

    await transaction(() async {
      await into(paymentTable).insertOnConflictUpdate(
        PaymentTableCompanion.insert(
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
      return PaymentInsertOrUpdateResponse(
        isNewPayment: true,
        message: "Berhasil membuat detail transaksi dengan kode ${form.id}",
      );
    }
    return PaymentInsertOrUpdateResponse(
      isNewPayment: false,
      message: "Berhasil mengupdate detail transaksi dengan kode ${form.id}",
    );
  }

  Future<int> deletePayment(String id) async {
    final query = delete(paymentTable)..where((payment) => payment.id.equals(id));
    final result = await query.go();
    return result;
  }
}
