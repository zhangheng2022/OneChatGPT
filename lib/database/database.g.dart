// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ChatTablesTable extends ChatTables
    with TableInfo<$ChatTablesTable, ChatTable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatTablesTable(this.attachedDatabase, [this._alias]);
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
      requiredDuringInsert: true);
  static const VerificationMeta _datetimeMeta =
      const VerificationMeta('datetime');
  @override
  late final GeneratedColumn<DateTime> datetime = GeneratedColumn<DateTime>(
      'datetime', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, title, datetime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_tables';
  @override
  VerificationContext validateIntegrity(Insertable<ChatTable> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
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
  ChatTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatTable(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      datetime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}datetime'])!,
    );
  }

  @override
  $ChatTablesTable createAlias(String alias) {
    return $ChatTablesTable(attachedDatabase, alias);
  }
}

class ChatTable extends DataClass implements Insertable<ChatTable> {
  final int id;
  final String title;
  final DateTime datetime;
  const ChatTable(
      {required this.id, required this.title, required this.datetime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['datetime'] = Variable<DateTime>(datetime);
    return map;
  }

  ChatTablesCompanion toCompanion(bool nullToAbsent) {
    return ChatTablesCompanion(
      id: Value(id),
      title: Value(title),
      datetime: Value(datetime),
    );
  }

  factory ChatTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatTable(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      datetime: serializer.fromJson<DateTime>(json['datetime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'datetime': serializer.toJson<DateTime>(datetime),
    };
  }

  ChatTable copyWith({int? id, String? title, DateTime? datetime}) => ChatTable(
        id: id ?? this.id,
        title: title ?? this.title,
        datetime: datetime ?? this.datetime,
      );
  @override
  String toString() {
    return (StringBuffer('ChatTable(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('datetime: $datetime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, datetime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatTable &&
          other.id == this.id &&
          other.title == this.title &&
          other.datetime == this.datetime);
}

class ChatTablesCompanion extends UpdateCompanion<ChatTable> {
  final Value<int> id;
  final Value<String> title;
  final Value<DateTime> datetime;
  const ChatTablesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.datetime = const Value.absent(),
  });
  ChatTablesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.datetime = const Value.absent(),
  }) : title = Value(title);
  static Insertable<ChatTable> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<DateTime>? datetime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (datetime != null) 'datetime': datetime,
    });
  }

  ChatTablesCompanion copyWith(
      {Value<int>? id, Value<String>? title, Value<DateTime>? datetime}) {
    return ChatTablesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
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
    if (datetime.present) {
      map['datetime'] = Variable<DateTime>(datetime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatTablesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('datetime: $datetime')
          ..write(')'))
        .toString();
  }
}

class $ChatContentTablesTable extends ChatContentTables
    with TableInfo<$ChatContentTablesTable, ChatContentTable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatContentTablesTable(this.attachedDatabase, [this._alias]);
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
      check: () => contentType.regexp(r'^(user|chat)', caseSensitive: false),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('user'));
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
  static const String $name = 'chat_content_tables';
  @override
  VerificationContext validateIntegrity(Insertable<ChatContentTable> instance,
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
  ChatContentTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatContentTable(
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
  $ChatContentTablesTable createAlias(String alias) {
    return $ChatContentTablesTable(attachedDatabase, alias);
  }
}

class ChatContentTable extends DataClass
    implements Insertable<ChatContentTable> {
  final int id;
  final int parentid;
  final String title;
  final String content;
  final String contentType;
  final DateTime datetime;
  const ChatContentTable(
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

  ChatContentTablesCompanion toCompanion(bool nullToAbsent) {
    return ChatContentTablesCompanion(
      id: Value(id),
      parentid: Value(parentid),
      title: Value(title),
      content: Value(content),
      contentType: Value(contentType),
      datetime: Value(datetime),
    );
  }

  factory ChatContentTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatContentTable(
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

  ChatContentTable copyWith(
          {int? id,
          int? parentid,
          String? title,
          String? content,
          String? contentType,
          DateTime? datetime}) =>
      ChatContentTable(
        id: id ?? this.id,
        parentid: parentid ?? this.parentid,
        title: title ?? this.title,
        content: content ?? this.content,
        contentType: contentType ?? this.contentType,
        datetime: datetime ?? this.datetime,
      );
  @override
  String toString() {
    return (StringBuffer('ChatContentTable(')
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
      (other is ChatContentTable &&
          other.id == this.id &&
          other.parentid == this.parentid &&
          other.title == this.title &&
          other.content == this.content &&
          other.contentType == this.contentType &&
          other.datetime == this.datetime);
}

class ChatContentTablesCompanion extends UpdateCompanion<ChatContentTable> {
  final Value<int> id;
  final Value<int> parentid;
  final Value<String> title;
  final Value<String> content;
  final Value<String> contentType;
  final Value<DateTime> datetime;
  const ChatContentTablesCompanion({
    this.id = const Value.absent(),
    this.parentid = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.contentType = const Value.absent(),
    this.datetime = const Value.absent(),
  });
  ChatContentTablesCompanion.insert({
    this.id = const Value.absent(),
    required int parentid,
    required String title,
    required String content,
    this.contentType = const Value.absent(),
    this.datetime = const Value.absent(),
  })  : parentid = Value(parentid),
        title = Value(title),
        content = Value(content);
  static Insertable<ChatContentTable> custom({
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

  ChatContentTablesCompanion copyWith(
      {Value<int>? id,
      Value<int>? parentid,
      Value<String>? title,
      Value<String>? content,
      Value<String>? contentType,
      Value<DateTime>? datetime}) {
    return ChatContentTablesCompanion(
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
    return (StringBuffer('ChatContentTablesCompanion(')
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
  late final $ChatTablesTable chatTables = $ChatTablesTable(this);
  late final $ChatContentTablesTable chatContentTables =
      $ChatContentTablesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [chatTables, chatContentTables];
}
