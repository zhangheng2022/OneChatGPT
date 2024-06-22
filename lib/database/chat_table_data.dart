import 'package:drift/drift.dart';

class ChatTableData extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title =>
      text().withLength(min: 1, max: 20).withDefault(const Constant("新的对话"))();
  BoolColumn get isupdate => boolean().withDefault(const Constant(true))();
  DateTimeColumn get datetime => dateTime().withDefault(currentDateAndTime)();
}
