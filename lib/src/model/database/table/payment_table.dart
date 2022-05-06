part of '../my_database.dart';

class PaymentTable extends Table {
  @override
  String get tableName => "payment";

  TextColumn get id => text().clientDefault(() => const Uuid().v4())();

  TextColumn get peopleId => text()
      .references(PeoplesTable, #id, onDelete: KeyAction.cascade)
      .clientDefault(() => const Uuid().v4())();

  TextColumn get transactionId => text()
      .references(TransactionTable, #id, onDelete: KeyAction.cascade)
      .clientDefault(() => const Uuid().v4())();

  IntColumn get amount => integer()();

  DateTimeColumn get date => dateTime()();

  TextColumn get description => text().nullable()();

  TextColumn get attachmentPath => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
