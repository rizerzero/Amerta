part of '../config_database.dart';

@DataClassName("transaction")
class TransactionTable extends Table {
  @override
  String get tableName => "transaction";

  TextColumn get id => text().clientDefault(() => const Uuid().v4())();

  TextColumn get peopleId => text()
      .references(PeoplesTable, #id, onDelete: KeyAction.cascade)
      .clientDefault(() => const Uuid().v4())();

  TextColumn get title => text()();

  IntColumn get amount => integer()();

  DateTimeColumn get date => dateTime()();

  TextColumn get description => text()();

  BlobColumn get attachment => blob()();

  TextColumn get paymentStatus => text()();

  TextColumn get transactionType => text()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();
}
