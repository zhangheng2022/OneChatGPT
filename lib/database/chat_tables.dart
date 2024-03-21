import 'package:drift/drift.dart';

class ChatTables extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 20)();
  DateTimeColumn get datetime => dateTime()();
}
