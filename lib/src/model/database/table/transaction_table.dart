part of '../config_database.dart';

class TransactionTable extends Table {
  @override
  String get tableName => "transaction_table";

  TextColumn get id => text().clientDefault(() => const Uuid().v4())();

  TextColumn get peopleId => text()
      .references(PeoplesTable, #id, onDelete: KeyAction.cascade)
      .clientDefault(() => const Uuid().v4())();

  TextColumn get title => text()();

  IntColumn get amount => integer()();

  DateTimeColumn get loanDate => dateTime()();

  DateTimeColumn get returnDate => dateTime().nullable()();

  TextColumn get description => text().nullable()();

  TextColumn get attachmentPath => text().nullable()();

  TextColumn get paymentStatus => text().named('payment_status')();

  TextColumn get transactionType => text().named("transaction_type")();

  DateTimeColumn get createdAt => dateTime().named("created_at")();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
