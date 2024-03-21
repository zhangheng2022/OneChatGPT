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
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
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
    } else if (isInserting) {
      context.missing(_datetimeMeta);
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
    required DateTime datetime,
  })  : title = Value(title),
        datetime = Value(datetime);
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $ChatTablesTable chatTables = $ChatTablesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [chatTables];
}
