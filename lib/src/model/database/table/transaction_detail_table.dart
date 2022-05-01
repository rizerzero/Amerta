part of '../config_database.dart';

class TransactionDetailTable extends Table {
  @override
  String get tableName => "transaction_detail";

  TextColumn get id => text().clientDefault(() => const Uuid().v4())();

  TextColumn get peopleId => text()
      .references(PeoplesTable, #id, onDelete: KeyAction.cascade)
      .clientDefault(() => const Uuid().v4())();

  TextColumn get transactionId => text()
      .references(TransactionTable, #id, onDelete: KeyAction.cascade)
      .clientDefault(() => const Uuid().v4())();

  IntColumn get amount => integer()();

  TextColumn get description => text()();

  BlobColumn get attachment => blob()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();
}
