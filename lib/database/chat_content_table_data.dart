import 'package:drift/drift.dart';

class ChatContentTableData extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentid => integer()();
  TextColumn get title => text().withLength(min: 1, max: 20)();
  TextColumn get textarea => text().nullable()();
  TextColumn get role => text().withLength(min: 4, max: 10)();
  TextColumn get contentType => text()();
  TextColumn get fileUri => text().nullable()();
  IntColumn get fileSize => integer().nullable()();
  DateTimeColumn get datetime => dateTime().withDefault(currentDateAndTime)();
}
