import 'package:drift/drift.dart';

class ChatRecordDetail extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get chatId => integer()();
  TextColumn get messageId => text().unique()();
  TextColumn get message => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
