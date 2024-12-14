import 'package:drift/drift.dart';
import 'chat_table_data.dart';

enum RoleEnum { user, assistant, system }

enum ContentTypeEnum { text, image, file }

class ChatContentTableData extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentid => integer()();
  TextColumn get title => text()();
  TextColumn get content => text().nullable()();
  TextColumn get contentType => textEnum<ContentTypeEnum>()();
  TextColumn get role => textEnum<RoleEnum>()();
  TextColumn get fileUri => text().nullable()();
  IntColumn get fileSize => integer().nullable()();
  TextColumn get preset => textEnum<PresetEnum>()
      .withDefault(Constant(PresetEnum.comprehensive.toString()))();
  DateTimeColumn get datetime => dateTime().withDefault(currentDateAndTime)();
}
