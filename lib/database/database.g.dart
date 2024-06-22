// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ChatTableDataTable extends ChatTableData
    with TableInfo<$ChatTableDataTable, ChatTableDataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatTableDataTable(this.attachedDatabase, [this._alias]);
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
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant("新的对话"));
  static const VerificationMeta _isupdateMeta =
      const VerificationMeta('isupdate');
  @override
  late final GeneratedColumn<bool> isupdate = GeneratedColumn<bool>(
      'isupdate', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("isupdate" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _datetimeMeta =
      const VerificationMeta('datetime');
  @override
  late final GeneratedColumn<DateTime> datetime = GeneratedColumn<DateTime>(
      'datetime', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, title, isupdate, datetime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_table_data';
  @override
  VerificationContext validateIntegrity(Insertable<ChatTableDataData> instance,
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
    if (data.containsKey('isupdate')) {
      context.handle(_isupdateMeta,
          isupdate.isAcceptableOrUnknown(data['isupdate']!, _isupdateMeta));
    }
    if (data.containsKey('datetime')) {
      context.handle(_datetimeMeta,
          datetime.isAcceptableOrUnknown(data['datetime']!, _datetimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatTableDataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatTableDataData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      isupdate: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}isupdate'])!,
      datetime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}datetime'])!,
    );
  }

  @override
  $ChatTableDataTable createAlias(String alias) {
    return $ChatTableDataTable(attachedDatabase, alias);
  }
}

class ChatTableDataData extends DataClass
    implements Insertable<ChatTableDataData> {
  final int id;
  final String title;
  final bool isupdate;
  final DateTime datetime;
  const ChatTableDataData(
      {required this.id,
      required this.title,
      required this.isupdate,
      required this.datetime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['isupdate'] = Variable<bool>(isupdate);
    map['datetime'] = Variable<DateTime>(datetime);
    return map;
  }

  ChatTableDataCompanion toCompanion(bool nullToAbsent) {
    return ChatTableDataCompanion(
      id: Value(id),
      title: Value(title),
      isupdate: Value(isupdate),
      datetime: Value(datetime),
    );
  }

  factory ChatTableDataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatTableDataData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      isupdate: serializer.fromJson<bool>(json['isupdate']),
      datetime: serializer.fromJson<DateTime>(json['datetime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'isupdate': serializer.toJson<bool>(isupdate),
      'datetime': serializer.toJson<DateTime>(datetime),
    };
  }

  ChatTableDataData copyWith(
          {int? id, String? title, bool? isupdate, DateTime? datetime}) =>
      ChatTableDataData(
        id: id ?? this.id,
        title: title ?? this.title,
        isupdate: isupdate ?? this.isupdate,
        datetime: datetime ?? this.datetime,
      );
  @override
  String toString() {
    return (StringBuffer('ChatTableDataData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('isupdate: $isupdate, ')
          ..write('datetime: $datetime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, isupdate, datetime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatTableDataData &&
          other.id == this.id &&
          other.title == this.title &&
          other.isupdate == this.isupdate &&
          other.datetime == this.datetime);
}

class ChatTableDataCompanion extends UpdateCompanion<ChatTableDataData> {
  final Value<int> id;
  final Value<String> title;
  final Value<bool> isupdate;
  final Value<DateTime> datetime;
  const ChatTableDataCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.isupdate = const Value.absent(),
    this.datetime = const Value.absent(),
  });
  ChatTableDataCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.isupdate = const Value.absent(),
    this.datetime = const Value.absent(),
  });
  static Insertable<ChatTableDataData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<bool>? isupdate,
    Expression<DateTime>? datetime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (isupdate != null) 'isupdate': isupdate,
      if (datetime != null) 'datetime': datetime,
    });
  }

  ChatTableDataCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<bool>? isupdate,
      Value<DateTime>? datetime}) {
    return ChatTableDataCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      isupdate: isupdate ?? this.isupdate,
      datetime: datetime ?? this.datetime,
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
    if (isupdate.present) {
      map['isupdate'] = Variable<bool>(isupdate.value);
    }
    if (datetime.present) {
      map['datetime'] = Variable<DateTime>(datetime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatTableDataCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('isupdate: $isupdate, ')
          ..write('datetime: $datetime')
          ..write(')'))
        .toString();
  }
}

class $ChatContentTableDataTable extends ChatContentTableData
    with TableInfo<$ChatContentTableDataTable, ChatContentTableDataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatContentTableDataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _parentidMeta =
      const VerificationMeta('parentid');
  @override
  late final GeneratedColumn<int> parentid = GeneratedColumn<int>(
      'parentid', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentTypeMeta =
      const VerificationMeta('contentType');
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
      'content_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _datetimeMeta =
      const VerificationMeta('datetime');
  @override
  late final GeneratedColumn<DateTime> datetime = GeneratedColumn<DateTime>(
      'datetime', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, parentid, title, content, contentType, datetime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_content_table_data';
  @override
  VerificationContext validateIntegrity(
      Insertable<ChatContentTableDataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('parentid')) {
      context.handle(_parentidMeta,
          parentid.isAcceptableOrUnknown(data['parentid']!, _parentidMeta));
    } else if (isInserting) {
      context.missing(_parentidMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('content_type')) {
      context.handle(
          _contentTypeMeta,
          contentType.isAcceptableOrUnknown(
              data['content_type']!, _contentTypeMeta));
    } else if (isInserting) {
      context.missing(_contentTypeMeta);
    }
    if (data.containsKey('datetime')) {
      context.handle(_datetimeMeta,
          datetime.isAcceptableOrUnknown(data['datetime']!, _datetimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatContentTableDataData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatContentTableDataData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      parentid: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parentid'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      contentType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_type'])!,
      datetime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}datetime'])!,
    );
  }

  @override
  $ChatContentTableDataTable createAlias(String alias) {
    return $ChatContentTableDataTable(attachedDatabase, alias);
  }
}

class ChatContentTableDataData extends DataClass
    implements Insertable<ChatContentTableDataData> {
  final int id;
  final int parentid;
  final String title;
  final String content;
  final String contentType;
  final DateTime datetime;
  const ChatContentTableDataData(
      {required this.id,
      required this.parentid,
      required this.title,
      required this.content,
      required this.contentType,
      required this.datetime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['parentid'] = Variable<int>(parentid);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['content_type'] = Variable<String>(contentType);
    map['datetime'] = Variable<DateTime>(datetime);
    return map;
  }

  ChatContentTableDataCompanion toCompanion(bool nullToAbsent) {
    return ChatContentTableDataCompanion(
      id: Value(id),
      parentid: Value(parentid),
      title: Value(title),
      content: Value(content),
      contentType: Value(contentType),
      datetime: Value(datetime),
    );
  }

  factory ChatContentTableDataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatContentTableDataData(
      id: serializer.fromJson<int>(json['id']),
      parentid: serializer.fromJson<int>(json['parentid']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      contentType: serializer.fromJson<String>(json['contentType']),
      datetime: serializer.fromJson<DateTime>(json['datetime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'parentid': serializer.toJson<int>(parentid),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'contentType': serializer.toJson<String>(contentType),
      'datetime': serializer.toJson<DateTime>(datetime),
    };
  }

  ChatContentTableDataData copyWith(
          {int? id,
          int? parentid,
          String? title,
          String? content,
          String? contentType,
          DateTime? datetime}) =>
      ChatContentTableDataData(
        id: id ?? this.id,
        parentid: parentid ?? this.parentid,
        title: title ?? this.title,
        content: content ?? this.content,
        contentType: contentType ?? this.contentType,
        datetime: datetime ?? this.datetime,
      );
  @override
  String toString() {
    return (StringBuffer('ChatContentTableDataData(')
          ..write('id: $id, ')
          ..write('parentid: $parentid, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('contentType: $contentType, ')
          ..write('datetime: $datetime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, parentid, title, content, contentType, datetime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatContentTableDataData &&
          other.id == this.id &&
          other.parentid == this.parentid &&
          other.title == this.title &&
          other.content == this.content &&
          other.contentType == this.contentType &&
          other.datetime == this.datetime);
}

class ChatContentTableDataCompanion
    extends UpdateCompanion<ChatContentTableDataData> {
  final Value<int> id;
  final Value<int> parentid;
  final Value<String> title;
  final Value<String> content;
  final Value<String> contentType;
  final Value<DateTime> datetime;
  const ChatContentTableDataCompanion({
    this.id = const Value.absent(),
    this.parentid = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.contentType = const Value.absent(),
    this.datetime = const Value.absent(),
  });
  ChatContentTableDataCompanion.insert({
    this.id = const Value.absent(),
    required int parentid,
    required String title,
    required String content,
    required String contentType,
    this.datetime = const Value.absent(),
  })  : parentid = Value(parentid),
        title = Value(title),
        content = Value(content),
        contentType = Value(contentType);
  static Insertable<ChatContentTableDataData> custom({
    Expression<int>? id,
    Expression<int>? parentid,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? contentType,
    Expression<DateTime>? datetime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parentid != null) 'parentid': parentid,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (contentType != null) 'content_type': contentType,
      if (datetime != null) 'datetime': datetime,
    });
  }

  ChatContentTableDataCompanion copyWith(
      {Value<int>? id,
      Value<int>? parentid,
      Value<String>? title,
      Value<String>? content,
      Value<String>? contentType,
      Value<DateTime>? datetime}) {
    return ChatContentTableDataCompanion(
      id: id ?? this.id,
      parentid: parentid ?? this.parentid,
      title: title ?? this.title,
      content: content ?? this.content,
      contentType: contentType ?? this.contentType,
      datetime: datetime ?? this.datetime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (parentid.present) {
      map['parentid'] = Variable<int>(parentid.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (datetime.present) {
      map['datetime'] = Variable<DateTime>(datetime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatContentTableDataCompanion(')
          ..write('id: $id, ')
          ..write('parentid: $parentid, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('contentType: $contentType, ')
          ..write('datetime: $datetime')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $ChatTableDataTable chatTableData = $ChatTableDataTable(this);
  late final $ChatContentTableDataTable chatContentTableData =
      $ChatContentTableDataTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [chatTableData, chatContentTableData];
}

typedef $$ChatTableDataTableInsertCompanionBuilder = ChatTableDataCompanion
    Function({
  Value<int> id,
  Value<String> title,
  Value<bool> isupdate,
  Value<DateTime> datetime,
});
typedef $$ChatTableDataTableUpdateCompanionBuilder = ChatTableDataCompanion
    Function({
  Value<int> id,
  Value<String> title,
  Value<bool> isupdate,
  Value<DateTime> datetime,
});

class $$ChatTableDataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatTableDataTable,
    ChatTableDataData,
    $$ChatTableDataTableFilterComposer,
    $$ChatTableDataTableOrderingComposer,
    $$ChatTableDataTableProcessedTableManager,
    $$ChatTableDataTableInsertCompanionBuilder,
    $$ChatTableDataTableUpdateCompanionBuilder> {
  $$ChatTableDataTableTableManager(_$AppDatabase db, $ChatTableDataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ChatTableDataTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ChatTableDataTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$ChatTableDataTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<bool> isupdate = const Value.absent(),
            Value<DateTime> datetime = const Value.absent(),
          }) =>
              ChatTableDataCompanion(
            id: id,
            title: title,
            isupdate: isupdate,
            datetime: datetime,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<bool> isupdate = const Value.absent(),
            Value<DateTime> datetime = const Value.absent(),
          }) =>
              ChatTableDataCompanion.insert(
            id: id,
            title: title,
            isupdate: isupdate,
            datetime: datetime,
          ),
        ));
}

class $$ChatTableDataTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $ChatTableDataTable,
    ChatTableDataData,
    $$ChatTableDataTableFilterComposer,
    $$ChatTableDataTableOrderingComposer,
    $$ChatTableDataTableProcessedTableManager,
    $$ChatTableDataTableInsertCompanionBuilder,
    $$ChatTableDataTableUpdateCompanionBuilder> {
  $$ChatTableDataTableProcessedTableManager(super.$state);
}

class $$ChatTableDataTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ChatTableDataTable> {
  $$ChatTableDataTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isupdate => $state.composableBuilder(
      column: $state.table.isupdate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get datetime => $state.composableBuilder(
      column: $state.table.datetime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ChatTableDataTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ChatTableDataTable> {
  $$ChatTableDataTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isupdate => $state.composableBuilder(
      column: $state.table.isupdate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get datetime => $state.composableBuilder(
      column: $state.table.datetime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ChatContentTableDataTableInsertCompanionBuilder
    = ChatContentTableDataCompanion Function({
  Value<int> id,
  required int parentid,
  required String title,
  required String content,
  required String contentType,
  Value<DateTime> datetime,
});
typedef $$ChatContentTableDataTableUpdateCompanionBuilder
    = ChatContentTableDataCompanion Function({
  Value<int> id,
  Value<int> parentid,
  Value<String> title,
  Value<String> content,
  Value<String> contentType,
  Value<DateTime> datetime,
});

class $$ChatContentTableDataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatContentTableDataTable,
    ChatContentTableDataData,
    $$ChatContentTableDataTableFilterComposer,
    $$ChatContentTableDataTableOrderingComposer,
    $$ChatContentTableDataTableProcessedTableManager,
    $$ChatContentTableDataTableInsertCompanionBuilder,
    $$ChatContentTableDataTableUpdateCompanionBuilder> {
  $$ChatContentTableDataTableTableManager(
      _$AppDatabase db, $ChatContentTableDataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$ChatContentTableDataTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$ChatContentTableDataTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$ChatContentTableDataTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int> parentid = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> contentType = const Value.absent(),
            Value<DateTime> datetime = const Value.absent(),
          }) =>
              ChatContentTableDataCompanion(
            id: id,
            parentid: parentid,
            title: title,
            content: content,
            contentType: contentType,
            datetime: datetime,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required int parentid,
            required String title,
            required String content,
            required String contentType,
            Value<DateTime> datetime = const Value.absent(),
          }) =>
              ChatContentTableDataCompanion.insert(
            id: id,
            parentid: parentid,
            title: title,
            content: content,
            contentType: contentType,
            datetime: datetime,
          ),
        ));
}

class $$ChatContentTableDataTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $ChatContentTableDataTable,
        ChatContentTableDataData,
        $$ChatContentTableDataTableFilterComposer,
        $$ChatContentTableDataTableOrderingComposer,
        $$ChatContentTableDataTableProcessedTableManager,
        $$ChatContentTableDataTableInsertCompanionBuilder,
        $$ChatContentTableDataTableUpdateCompanionBuilder> {
  $$ChatContentTableDataTableProcessedTableManager(super.$state);
}

class $$ChatContentTableDataTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ChatContentTableDataTable> {
  $$ChatContentTableDataTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get parentid => $state.composableBuilder(
      column: $state.table.parentid,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get contentType => $state.composableBuilder(
      column: $state.table.contentType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get datetime => $state.composableBuilder(
      column: $state.table.datetime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ChatContentTableDataTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ChatContentTableDataTable> {
  $$ChatContentTableDataTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get parentid => $state.composableBuilder(
      column: $state.table.parentid,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get contentType => $state.composableBuilder(
      column: $state.table.contentType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get datetime => $state.composableBuilder(
      column: $state.table.datetime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$ChatTableDataTableTableManager get chatTableData =>
      $$ChatTableDataTableTableManager(_db, _db.chatTableData);
  $$ChatContentTableDataTableTableManager get chatContentTableData =>
      $$ChatContentTableDataTableTableManager(_db, _db.chatContentTableData);
}
