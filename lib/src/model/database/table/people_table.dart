part of '../my_database.dart';

class PeoplesTable extends Table {
  @override
  String get tableName => "people";

  TextColumn get id => text().clientDefault(() => const Uuid().v4())();

  TextColumn get name => text()();

  TextColumn get imagePath => text().nullable()();

  DateTimeColumn get createdAt => dateTime().nullable()();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
