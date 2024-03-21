import 'package:drift/drift.dart';

class ChatContentTables extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentid => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 20)();
  TextColumn get content => text()();
  DateTimeColumn get datetime => dateTime()();
}
