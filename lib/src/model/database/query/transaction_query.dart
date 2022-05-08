import 'package:collection/collection.dart';
import 'package:drift/drift.dart';

import '../../../utils/utils.dart';
import '../../model/people/people_model.dart';
import '../../model/transaction/form_transaction_parameter.dart';
import '../../model/transaction/recent_transaction_model.dart';
import '../../model/transaction/summary_transaction_model.dart';
import '../../model/transaction/transaction_insertorupdate_response.dart';
import '../../model/transaction/transaction_model.dart';
import '../my_database.dart';
import 'people_query.dart';

class TransactionTableQuery extends MyDatabase {
  ///* [Transaction Section]

  TransactionTableQuery({
    required this.peopleQuery,
  });

  final PeopleTableQuery peopleQuery;

  Future<List<SummaryTransactionModel>> getSummaryTransaction(String? peopleId) async {
    String query = "";

    if (peopleId != null) {
      /// Transaction Summary for specific people
      query = """
        SELECT
          t1.`transaction_type`,
          t1.`amount` AS total_amount,
          (SELECT
            SUM(amount)
          FROM
            ${paymentTable.tableName}
          WHERE `transaction_id` = t1.id) AS total_amount_payment
        FROM
          ${transactionTable.tableName} AS t1
        WHERE t1.`people_id` = ?
        GROUP BY
          t1.`transaction_type`,
          t1.`amount`,
          `total_amount_payment`
        """;
    } else {
      /// Transaction summary for owner application
      query = """
        SELECT
          t1.`transaction_type`,
          SUM(`amount`) AS total_amount,
          (SELECT
            SUM(sub1.amount)
          FROM
            ${paymentTable.tableName} AS sub1
            JOIN ${transactionTable.tableName} AS sub2
              ON (sub1.transaction_id = sub2.id)
          WHERE sub2.transaction_type = t1.`transaction_type`) AS total_amount_payment
        FROM
          ${transactionTable.tableName} AS t1
        GROUP BY t1.`transaction_type` 
       """;
    }

    final result = customSelect(
      query,
      readsFrom: {
        transactionTable,
        peoplesTable,
      },
      variables: [
        if (peopleId != null) Variable.withString(peopleId),
      ],
    ).map(
      (row) {
        return SummaryTransactionModel(
          totalAmount: row.read<int?>("total_amount"),
          totalAmountPayment: row.read<int?>("total_amount_payment"),
          transactionType: TransactionType.values.firstWhereOrNull(
            (element) => element.name == row.read<String?>("transaction_type"),
          ),
        );
      },
    ).get();

    return result;
  }

  Future<List<RecentTransactionModel>> getTransactions({
    required TransactionType type,
    PaymentStatus? paymentStatus,
    String? peopleId,
    int? limit,
  }) async {
    String where = "WHERE t1.transaction_type = ?";
    String qLimit = "";

    if (peopleId != null) where += " AND t1.people_id = ? ";
    if (paymentStatus != null) where += " AND t1.payment_status = ?";
    if (limit != null) qLimit += "LIMIT $limit";

    final query = """
                SELECT t1.id, t1.title, t1.amount, t1.transaction_type, t1.loan_date, t1.return_date,
                t1.description, t1.payment_status,
                t2.id as people_id, t2.name as people_name, t2.image_path as people_image_path,
                (SELECT SUM(amount) FROM ${paymentTable.tableName} WHERE transaction_id = t1.id ) as amount_payment

                FROM ${transactionTable.tableName} as t1
                JOIN ${peoplesTable.tableName} as t2 ON (t2.id = t1.people_id)
                $where $qLimit
""";

    final result = customSelect(
      query,
      variables: [
        Variable.withString(type.name),
        if (peopleId != null) Variable.withString(peopleId),
        if (limit != null) Variable.withInt(limit),
        if (paymentStatus != null) Variable.withString(paymentStatus.name)
      ],
      readsFrom: {
        transactionTable,
        peoplesTable,
      },
    ).map((row) {
      return RecentTransactionModel(
        transactionId: row.read<String>("id"),
        amount: row.read<int>("amount"),
        amountPayment: row.read<int?>("amount_payment"),
        title: row.read<String>("title"),
        type: TransactionType.values.byName(row.read<String>("transaction_type")),
        paymentStatus: PaymentStatus.values.byName(row.read<String>("payment_status")),
        loanDate: fn.dateTimeFromUnix(row.read("loan_date"))!,
        returnDate: fn.dateTimeFromUnix(row.read("return_date")),
        description: row.read("description"),
        people: PeopleModel(
          peopleId: row.read<String>("people_id"),
          name: row.read<String>("people_name"),
          imagePath: row.read<String?>("people_image_path"),
        ),
      );
    }).get();

    return result;
  }

  Future<TransactionModel?> getById(String? id) async {
    if (id == null) return null;

    final query = select(transactionTable)..where((trx) => trx.id.equals(id));

    final result = await query.map(
      (row) async {
        return TransactionModel(
          id: row.id,
          amount: row.amount,
          attachmentPath: row.attachmentPath,
          description: row.description,
          peopleId: row.peopleId,
          returnDate: row.returnDate,
          status: PaymentStatus.values.byName(row.paymentStatus),
          title: row.title,
          type: TransactionType.values.byName(row.transactionType),
          updatedAt: row.updatedAt,
          loanDate: row.loanDate,
          createdAt: row.createdAt,
          people: await peopleQuery.getById(row.peopleId),
        );
      },
    ).getSingleOrNull();

    return result;
  }

  /// TODO: Save Image to documentDirectory when success create transaction
  Future<TransactionInsertOrUpdateResponse> insertOrUpdateTransaction(
      FormTransactionParameter form) async {
    final trx = await (select(transactionTable)..where((t) => t.id.equals(form.transactionId)))
        .getSingleOrNull();

    transaction(() async {
      await into(transactionTable).insertOnConflictUpdate(
        TransactionTableCompanion(
          id: Value(form.transactionId!),
          peopleId: Value(form.selectedPeople!.peopleId),
          title: Value(form.title),
          amount: Value(form.amount),
          attachmentPath: Value(form.attachment?.path),
          createdAt: Value(form.createdAt),
          description: Value(form.description),
          loanDate: Value(form.loanDate),
          returnDate: Value(form.returnDate),
          paymentStatus: Value(form.paymentStatus.name),
          transactionType: Value(form.transactionType.name),
          updatedAt: Value(form.updatedAt),
        ),
      );
    });

    if (trx == null) {
      return TransactionInsertOrUpdateResponse(
        isNewTransaction: true,
        message: "Berhasil membuat transaksi ${form.title}",
      );
    }

    return TransactionInsertOrUpdateResponse(
      isNewTransaction: false,
      message: "Berhasil mengupdate transaksi ${form.title}",
    );
  }

  Future<int> deleteTransaction(String id) async {
    final query = delete(transactionTable)..where((trx) => trx.id.equals(id));
    final result = await query.go();
    return result;
  }
}
