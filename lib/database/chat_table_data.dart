import 'package:drift/drift.dart';

enum PresetEnum { comprehensive, code, image, document }

class ChatTableData extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withDefault(const Constant("新的对话"))();
  BoolColumn get autoTitle => boolean().withDefault(const Constant(true))();
  DateTimeColumn get datetime => dateTime().withDefault(currentDateAndTime)();
  TextColumn get preset =>
      textEnum<PresetEnum>().withDefault(Constant("comprehensive"))();
}
