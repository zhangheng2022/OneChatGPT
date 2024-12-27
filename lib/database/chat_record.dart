import 'package:drift/drift.dart';

enum PresetEnum { chat, createImage }

class ChatRecord extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withDefault(Constant('新的话题'))();
  TextColumn get preset => textEnum<PresetEnum>()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
