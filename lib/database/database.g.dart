// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ChatRecordTable extends ChatRecord
    with TableInfo<$ChatRecordTable, ChatRecordData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatRecordTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant('新的话题'));
  static const VerificationMeta _presetMeta = const VerificationMeta('preset');
  @override
  late final GeneratedColumnWithTypeConverter<PresetEnum, String> preset =
      GeneratedColumn<String>('preset', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: Constant('comprehensive'))
          .withConverter<PresetEnum>($ChatRecordTable.$converterpreset);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, preset, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_record';
  @override
  VerificationContext validateIntegrity(Insertable<ChatRecordData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    context.handle(_presetMeta, const VerificationResult.success());
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatRecordData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatRecordData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      preset: $ChatRecordTable.$converterpreset.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}preset'])!),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ChatRecordTable createAlias(String alias) {
    return $ChatRecordTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PresetEnum, String, String> $converterpreset =
      const EnumNameConverter<PresetEnum>(PresetEnum.values);
}

class ChatRecordData extends DataClass implements Insertable<ChatRecordData> {
  final int id;
  final String title;
  final PresetEnum preset;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ChatRecordData(
      {required this.id,
      required this.title,
      required this.preset,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    {
      map['preset'] =
          Variable<String>($ChatRecordTable.$converterpreset.toSql(preset));
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ChatRecordCompanion toCompanion(bool nullToAbsent) {
    return ChatRecordCompanion(
      id: Value(id),
      title: Value(title),
      preset: Value(preset),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ChatRecordData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatRecordData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      preset: $ChatRecordTable.$converterpreset
          .fromJson(serializer.fromJson<String>(json['preset'])),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'preset': serializer
          .toJson<String>($ChatRecordTable.$converterpreset.toJson(preset)),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ChatRecordData copyWith(
          {int? id,
          String? title,
          PresetEnum? preset,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ChatRecordData(
        id: id ?? this.id,
        title: title ?? this.title,
        preset: preset ?? this.preset,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ChatRecordData copyWithCompanion(ChatRecordCompanion data) {
    return ChatRecordData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      preset: data.preset.present ? data.preset.value : this.preset,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatRecordData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('preset: $preset, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, preset, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatRecordData &&
          other.id == this.id &&
          other.title == this.title &&
          other.preset == this.preset &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ChatRecordCompanion extends UpdateCompanion<ChatRecordData> {
  final Value<int> id;
  final Value<String> title;
  final Value<PresetEnum> preset;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ChatRecordCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.preset = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ChatRecordCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.preset = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<ChatRecordData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? preset,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (preset != null) 'preset': preset,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ChatRecordCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<PresetEnum>? preset,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return ChatRecordCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      preset: preset ?? this.preset,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (preset.present) {
      map['preset'] = Variable<String>(
          $ChatRecordTable.$converterpreset.toSql(preset.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatRecordCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('preset: $preset, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ChatRecordDetailTable extends ChatRecordDetail
    with TableInfo<$ChatRecordDetailTable, ChatRecordDetailData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatRecordDetailTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
      'chat_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _messageIdMeta =
      const VerificationMeta('messageId');
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
      'message_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, chatId, messageId, message, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_record_detail';
  @override
  VerificationContext validateIntegrity(
      Insertable<ChatRecordDetailData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('chat_id')) {
      context.handle(_chatIdMeta,
          chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta));
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('message_id')) {
      context.handle(_messageIdMeta,
          messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta));
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatRecordDetailData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatRecordDetailData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      chatId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chat_id'])!,
      messageId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message_id'])!,
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ChatRecordDetailTable createAlias(String alias) {
    return $ChatRecordDetailTable(attachedDatabase, alias);
  }
}

class ChatRecordDetailData extends DataClass
    implements Insertable<ChatRecordDetailData> {
  final int id;
  final int chatId;
  final String messageId;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ChatRecordDetailData(
      {required this.id,
      required this.chatId,
      required this.messageId,
      required this.message,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['chat_id'] = Variable<int>(chatId);
    map['message_id'] = Variable<String>(messageId);
    map['message'] = Variable<String>(message);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ChatRecordDetailCompanion toCompanion(bool nullToAbsent) {
    return ChatRecordDetailCompanion(
      id: Value(id),
      chatId: Value(chatId),
      messageId: Value(messageId),
      message: Value(message),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ChatRecordDetailData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatRecordDetailData(
      id: serializer.fromJson<int>(json['id']),
      chatId: serializer.fromJson<int>(json['chatId']),
      messageId: serializer.fromJson<String>(json['messageId']),
      message: serializer.fromJson<String>(json['message']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'chatId': serializer.toJson<int>(chatId),
      'messageId': serializer.toJson<String>(messageId),
      'message': serializer.toJson<String>(message),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ChatRecordDetailData copyWith(
          {int? id,
          int? chatId,
          String? messageId,
          String? message,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ChatRecordDetailData(
        id: id ?? this.id,
        chatId: chatId ?? this.chatId,
        messageId: messageId ?? this.messageId,
        message: message ?? this.message,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ChatRecordDetailData copyWithCompanion(ChatRecordDetailCompanion data) {
    return ChatRecordDetailData(
      id: data.id.present ? data.id.value : this.id,
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      message: data.message.present ? data.message.value : this.message,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatRecordDetailData(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('messageId: $messageId, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, chatId, messageId, message, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatRecordDetailData &&
          other.id == this.id &&
          other.chatId == this.chatId &&
          other.messageId == this.messageId &&
          other.message == this.message &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ChatRecordDetailCompanion extends UpdateCompanion<ChatRecordDetailData> {
  final Value<int> id;
  final Value<int> chatId;
  final Value<String> messageId;
  final Value<String> message;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ChatRecordDetailCompanion({
    this.id = const Value.absent(),
    this.chatId = const Value.absent(),
    this.messageId = const Value.absent(),
    this.message = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ChatRecordDetailCompanion.insert({
    this.id = const Value.absent(),
    required int chatId,
    required String messageId,
    required String message,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : chatId = Value(chatId),
        messageId = Value(messageId),
        message = Value(message);
  static Insertable<ChatRecordDetailData> custom({
    Expression<int>? id,
    Expression<int>? chatId,
    Expression<String>? messageId,
    Expression<String>? message,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chatId != null) 'chat_id': chatId,
      if (messageId != null) 'message_id': messageId,
      if (message != null) 'message': message,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ChatRecordDetailCompanion copyWith(
      {Value<int>? id,
      Value<int>? chatId,
      Value<String>? messageId,
      Value<String>? message,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return ChatRecordDetailCompanion(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      messageId: messageId ?? this.messageId,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<int>(chatId.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatRecordDetailCompanion(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('messageId: $messageId, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ChatRecordTable chatRecord = $ChatRecordTable(this);
  late final $ChatRecordDetailTable chatRecordDetail =
      $ChatRecordDetailTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [chatRecord, chatRecordDetail];
}

typedef $$ChatRecordTableCreateCompanionBuilder = ChatRecordCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<PresetEnum> preset,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$ChatRecordTableUpdateCompanionBuilder = ChatRecordCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<PresetEnum> preset,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$ChatRecordTableFilterComposer
    extends Composer<_$AppDatabase, $ChatRecordTable> {
  $$ChatRecordTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<PresetEnum, PresetEnum, String> get preset =>
      $composableBuilder(
          column: $table.preset,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ChatRecordTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatRecordTable> {
  $$ChatRecordTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get preset => $composableBuilder(
      column: $table.preset, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ChatRecordTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatRecordTable> {
  $$ChatRecordTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PresetEnum, String> get preset =>
      $composableBuilder(column: $table.preset, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ChatRecordTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatRecordTable,
    ChatRecordData,
    $$ChatRecordTableFilterComposer,
    $$ChatRecordTableOrderingComposer,
    $$ChatRecordTableAnnotationComposer,
    $$ChatRecordTableCreateCompanionBuilder,
    $$ChatRecordTableUpdateCompanionBuilder,
    (
      ChatRecordData,
      BaseReferences<_$AppDatabase, $ChatRecordTable, ChatRecordData>
    ),
    ChatRecordData,
    PrefetchHooks Function()> {
  $$ChatRecordTableTableManager(_$AppDatabase db, $ChatRecordTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatRecordTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatRecordTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatRecordTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<PresetEnum> preset = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ChatRecordCompanion(
            id: id,
            title: title,
            preset: preset,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<PresetEnum> preset = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ChatRecordCompanion.insert(
            id: id,
            title: title,
            preset: preset,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChatRecordTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChatRecordTable,
    ChatRecordData,
    $$ChatRecordTableFilterComposer,
    $$ChatRecordTableOrderingComposer,
    $$ChatRecordTableAnnotationComposer,
    $$ChatRecordTableCreateCompanionBuilder,
    $$ChatRecordTableUpdateCompanionBuilder,
    (
      ChatRecordData,
      BaseReferences<_$AppDatabase, $ChatRecordTable, ChatRecordData>
    ),
    ChatRecordData,
    PrefetchHooks Function()>;
typedef $$ChatRecordDetailTableCreateCompanionBuilder
    = ChatRecordDetailCompanion Function({
  Value<int> id,
  required int chatId,
  required String messageId,
  required String message,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$ChatRecordDetailTableUpdateCompanionBuilder
    = ChatRecordDetailCompanion Function({
  Value<int> id,
  Value<int> chatId,
  Value<String> messageId,
  Value<String> message,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$ChatRecordDetailTableFilterComposer
    extends Composer<_$AppDatabase, $ChatRecordDetailTable> {
  $$ChatRecordDetailTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get chatId => $composableBuilder(
      column: $table.chatId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get messageId => $composableBuilder(
      column: $table.messageId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ChatRecordDetailTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatRecordDetailTable> {
  $$ChatRecordDetailTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get chatId => $composableBuilder(
      column: $table.chatId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get messageId => $composableBuilder(
      column: $table.messageId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ChatRecordDetailTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatRecordDetailTable> {
  $$ChatRecordDetailTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get chatId =>
      $composableBuilder(column: $table.chatId, builder: (column) => column);

  GeneratedColumn<String> get messageId =>
      $composableBuilder(column: $table.messageId, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ChatRecordDetailTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatRecordDetailTable,
    ChatRecordDetailData,
    $$ChatRecordDetailTableFilterComposer,
    $$ChatRecordDetailTableOrderingComposer,
    $$ChatRecordDetailTableAnnotationComposer,
    $$ChatRecordDetailTableCreateCompanionBuilder,
    $$ChatRecordDetailTableUpdateCompanionBuilder,
    (
      ChatRecordDetailData,
      BaseReferences<_$AppDatabase, $ChatRecordDetailTable,
          ChatRecordDetailData>
    ),
    ChatRecordDetailData,
    PrefetchHooks Function()> {
  $$ChatRecordDetailTableTableManager(
      _$AppDatabase db, $ChatRecordDetailTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatRecordDetailTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatRecordDetailTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatRecordDetailTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> chatId = const Value.absent(),
            Value<String> messageId = const Value.absent(),
            Value<String> message = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ChatRecordDetailCompanion(
            id: id,
            chatId: chatId,
            messageId: messageId,
            message: message,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int chatId,
            required String messageId,
            required String message,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ChatRecordDetailCompanion.insert(
            id: id,
            chatId: chatId,
            messageId: messageId,
            message: message,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChatRecordDetailTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChatRecordDetailTable,
    ChatRecordDetailData,
    $$ChatRecordDetailTableFilterComposer,
    $$ChatRecordDetailTableOrderingComposer,
    $$ChatRecordDetailTableAnnotationComposer,
    $$ChatRecordDetailTableCreateCompanionBuilder,
    $$ChatRecordDetailTableUpdateCompanionBuilder,
    (
      ChatRecordDetailData,
      BaseReferences<_$AppDatabase, $ChatRecordDetailTable,
          ChatRecordDetailData>
    ),
    ChatRecordDetailData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ChatRecordTableTableManager get chatRecord =>
      $$ChatRecordTableTableManager(_db, _db.chatRecord);
  $$ChatRecordDetailTableTableManager get chatRecordDetail =>
      $$ChatRecordDetailTableTableManager(_db, _db.chatRecordDetail);
}
