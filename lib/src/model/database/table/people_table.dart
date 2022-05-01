part of '../config_database.dart';

class PeoplesTable extends Table {
  @override
  String get tableName => "people";

  TextColumn get id => text().clientDefault(() => const Uuid().v4())();

  TextColumn get name => text()();

  BlobColumn get imagePath => blob()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedA => dateTime()();
}
