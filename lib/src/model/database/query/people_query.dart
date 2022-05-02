import 'package:drift/drift.dart';

import '../../../utils/utils.dart';
import '../../model/people/people_form_parameter.dart';
import '../../model/people/people_model.dart';
import '../../model/people/people_top_ten_model.dart';
import '../../model/people/peoples_model.dart';
import '../config_database.dart';

class PeopleTableQuery extends MyDatabase {
  ///* [People Section]

  Future<PeopleModel?> getById(String peopleId) async {
    final query = select(peoplesTable)..where((people) => people.id.equals(peopleId));

    final result = await query
        .map(
          (row) => PeopleModel(
            peopleId: row.id,
            createdAt: row.createdAt,
            updatedAt: row.updatedAt,
            imagePath: row.imagePath,
            name: row.name,
          ),
        )
        .getSingleOrNull();

    return result;
  }

  Future<List<PeopleTopTenModel>> getLatestTenPeople() async {
    var query = select(peoplesTable)
      ..orderBy(
        [
          (people) => OrderingTerm(expression: people.name, mode: OrderingMode.asc),
        ],
      )
      ..limit(10);
    final result = await query
        .map(
          (row) => PeopleTopTenModel(
            id: row.name,
            imagePath: row.imagePath,
            name: row.name,
          ),
        )
        .get();
    return result;
  }

  Future<List<PeoplesModel>> getPeoples() async {
    final query = customSelect("""
    SELECT
      t1.*,
      COUNT(t2.id) AS total_transaksi,
      ( SELECT COALESCE(SUM(amount),0) 
        FROM ${transactionTable.tableName} 
        WHERE `people_id` = t1.`id`
        AND `transaction_type` = 'hutang'
      ) AS totalHutang,

      ( SELECT COALESCE(SUM(amount),0)
        FROM ${transactionTable.tableName}
        WHERE `people_id` = t1.`id`
        AND `transaction_type` = 'piutang'
      ) AS totalPiutang
    FROM
      ${peoplesTable.tableName} AS t1
      LEFT JOIN ${transactionTable.tableName} AS t2
        ON (t1.`id` = t2.people_id)
      LEFT JOIN ${transactionDetailTable.tableName} AS t3
        ON (t2.`id` = t3.transaction_id)
    GROUP BY t1.id
""");

    final result = await query
        .map(
          (row) => PeoplesModel(
            people: PeopleModel(
              peopleId: row.read("id"),
              name: row.read("name"),
              imagePath: row.read("image_path"),
              createdAt: fn.dateTimeFromUnix(row.read<int?>("created_at")),
              updatedAt: fn.dateTimeFromUnix(row.read<int?>("updated_at")),
            ),
          ),
        )
        .get();
    return result;
  }

  Future<int> insertOrUpdatePeople(PeopleFormParameter form) async {
    final query = await into(peoplesTable).insertOnConflictUpdate(
      PeoplesTableCompanion(
        id: Value(form.people.peopleId),
        name: Value(form.people.name),
        imagePath: Value(form.people.imagePath),
        createdAt: Value(form.people.createdAt),
        updatedAt: Value(form.people.updatedAt),
      ),
    );
    return query;
  }

  Future<int> deletePeople(String id) async {
    final query = delete(peoplesTable)..where((people) => people.id.equals(id));
    final result = await query.go();
    return result;
  }
}
