import 'package:drift/drift.dart';

class ChatContentTables extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentid => integer()();
  TextColumn get title => text().withLength(min: 1, max: 20)();
  TextColumn get content => text()();
  TextColumn get contentType => text()();
  DateTimeColumn get datetime => dateTime().withDefault(currentDateAndTime)();
}
