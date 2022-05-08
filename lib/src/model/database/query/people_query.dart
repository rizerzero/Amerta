import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;

import '../../../utils/utils.dart';
import '../../model/people/form_people_parameter.dart';
import '../../model/people/people_insertorupdate_response.dart';
import '../../model/people/people_model.dart';
import '../../model/people/people_summary_model.dart';
import '../../model/people/people_top_ten_model.dart';
import '../my_database.dart';

class PeopleTableQuery extends MyDatabase {
  ///* [People Section]

  Future<List<PeopleModel>> get() async {
    final query = select(peoplesTable);
    final result = await query
        .map(
          (row) => PeopleModel(
            createdAt: row.createdAt,
            imagePath: row.imagePath,
            name: row.name,
            peopleId: row.id,
            updatedAt: row.updatedAt,
          ),
        )
        .get();
    return result;
  }

  Future<PeopleModel?> getById(String? peopleId) async {
    if (peopleId == null) return null;

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
          (people) => OrderingTerm(expression: people.createdAt, mode: OrderingMode.desc),
        ],
      );
    final result = await query
        .map(
          (row) => PeopleTopTenModel(
            id: row.id,
            imagePath: row.imagePath,
            name: row.name,
          ),
        )
        .get();

    return result;
  }

  Future<List<PeopleSummaryModel>> getPeopleSummary() async {
    final query = customSelect("""
          SELECT
            t1.*,
            COUNT(t2.`id`) AS total_transaksi,
            COALESCE(SUM(CASE WHEN t2.`transaction_type` = 'piutang' THEN t2.amount ELSE 0 END),0) AS total_piutang,
            COALESCE(SUM(CASE WHEN t2.`transaction_type` = 'hutang' THEN t2.amount ELSE 0 END),0) AS total_hutang 
          FROM
            ${peoplesTable.tableName} AS t1
            LEFT JOIN ${transactionTable.tableName} AS t2
              ON (t1.`id` = t2.`people_id`)
          GROUP BY t1.`id`
          ORDER BY total_transaksi DESC
""");

    final result = await query.map(
      (row) {
        return PeopleSummaryModel(
          totalHutang: row.read("total_hutang"),
          totalPiutang: row.read("total_piutang"),
          totalTransaksi: row.read("total_transaksi"),
          people: PeopleModel(
            peopleId: row.read("id"),
            name: row.read("name"),
            imagePath: row.read("image_path"),
            createdAt: fn.dateTimeFromUnix(row.read<int?>("created_at")),
            updatedAt: fn.dateTimeFromUnix(row.read<int?>("updated_at")),
          ),
        );
      },
    ).get();
    return result;
  }

  Future<PeopleInsertOrUpdateResponse> insertOrUpdatePeople(FormPeopleParameter form) async {
    final people = await (select(peoplesTable)..where((people) => people.id.equals(form.id)))
        .getSingleOrNull();

    await transaction(() async {
      File? tempFile;

      /// Check if have selected file/image
      if (form.image != null) {
        /// Jika [insert], berikan default nama [id_people]
        /// Jika [update], check apakah image path yang tersimpan sebelumnya masih null / tidak
        /// Jika masih null, berikan default nama [id_people]
        final filename = people == null ? form.id : p.basename(people.imagePath ?? form.id);
        final file = File(form.image!.path);

        final ext = p.extension(file.path);

        final path = await fn.generatePathFile("images/people", filename + ext);

        tempFile = file.copySync(path);
      }

      await into(peoplesTable).insertOnConflictUpdate(
        PeoplesTableCompanion(
          id: Value(form.id),
          name: Value(form.name),
          imagePath: Value(tempFile?.path),
          createdAt: Value(form.createdAt),
          updatedAt: Value(form.updatedAt),
        ),
      );
    });

    if (people == null) {
      return PeopleInsertOrUpdateResponse(
        message: "Berhasil membuat ${form.name}",
        isNewPeople: true,
      );
    }

    return PeopleInsertOrUpdateResponse(
      message: "Berhasil mengupdate ${form.name}",
      isNewPeople: false,
    );
  }

  Future<int> deletePeople(String id) async {
    final people =
        await (select(peoplesTable)..where((people) => people.id.equals(id))).getSingle();

    final query = delete(peoplesTable)..where((people) => people.id.equals(id));
    await transaction(() async {
      /// Operation Delete Image
      if (people.imagePath != null) {
        final image = File(people.imagePath!);
        final imageIsExists = image.existsSync();
        if (imageIsExists) {
          image.deleteSync(recursive: true);
        }
      }

      /// Running delete Query
      await query.go();
    });

    return 1;
  }
}
