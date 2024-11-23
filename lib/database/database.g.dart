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
  ChatTableDataData copyWithCompanion(ChatTableDataCompanion data) {
    return ChatTableDataData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      isupdate: data.isupdate.present ? data.isupdate.value : this.isupdate,
      datetime: data.datetime.present ? data.datetime.value : this.datetime,
    );
  }

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
  static const VerificationMeta _textareaMeta =
      const VerificationMeta('textarea');
  @override
  late final GeneratedColumn<String> textarea = GeneratedColumn<String>(
      'textarea', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 4, maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _contentTypeMeta =
      const VerificationMeta('contentType');
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
      'content_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fileUriMeta =
      const VerificationMeta('fileUri');
  @override
  late final GeneratedColumn<String> fileUri = GeneratedColumn<String>(
      'file_uri', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fileSizeMeta =
      const VerificationMeta('fileSize');
  @override
  late final GeneratedColumn<int> fileSize = GeneratedColumn<int>(
      'file_size', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _datetimeMeta =
      const VerificationMeta('datetime');
  @override
  late final GeneratedColumn<DateTime> datetime = GeneratedColumn<DateTime>(
      'datetime', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        parentid,
        title,
        textarea,
        role,
        contentType,
        fileUri,
        fileSize,
        datetime
      ];
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
    if (data.containsKey('textarea')) {
      context.handle(_textareaMeta,
          textarea.isAcceptableOrUnknown(data['textarea']!, _textareaMeta));
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('content_type')) {
      context.handle(
          _contentTypeMeta,
          contentType.isAcceptableOrUnknown(
              data['content_type']!, _contentTypeMeta));
    } else if (isInserting) {
      context.missing(_contentTypeMeta);
    }
    if (data.containsKey('file_uri')) {
      context.handle(_fileUriMeta,
          fileUri.isAcceptableOrUnknown(data['file_uri']!, _fileUriMeta));
    }
    if (data.containsKey('file_size')) {
      context.handle(_fileSizeMeta,
          fileSize.isAcceptableOrUnknown(data['file_size']!, _fileSizeMeta));
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
      textarea: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}textarea']),
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      contentType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_type'])!,
      fileUri: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_uri']),
      fileSize: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}file_size']),
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
  final String? textarea;
  final String role;
  final String contentType;
  final String? fileUri;
  final int? fileSize;
  final DateTime datetime;
  const ChatContentTableDataData(
      {required this.id,
      required this.parentid,
      required this.title,
      this.textarea,
      required this.role,
      required this.contentType,
      this.fileUri,
      this.fileSize,
      required this.datetime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['parentid'] = Variable<int>(parentid);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || textarea != null) {
      map['textarea'] = Variable<String>(textarea);
    }
    map['role'] = Variable<String>(role);
    map['content_type'] = Variable<String>(contentType);
    if (!nullToAbsent || fileUri != null) {
      map['file_uri'] = Variable<String>(fileUri);
    }
    if (!nullToAbsent || fileSize != null) {
      map['file_size'] = Variable<int>(fileSize);
    }
    map['datetime'] = Variable<DateTime>(datetime);
    return map;
  }

  ChatContentTableDataCompanion toCompanion(bool nullToAbsent) {
    return ChatContentTableDataCompanion(
      id: Value(id),
      parentid: Value(parentid),
      title: Value(title),
      textarea: textarea == null && nullToAbsent
          ? const Value.absent()
          : Value(textarea),
      role: Value(role),
      contentType: Value(contentType),
      fileUri: fileUri == null && nullToAbsent
          ? const Value.absent()
          : Value(fileUri),
      fileSize: fileSize == null && nullToAbsent
          ? const Value.absent()
          : Value(fileSize),
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
      textarea: serializer.fromJson<String?>(json['textarea']),
      role: serializer.fromJson<String>(json['role']),
      contentType: serializer.fromJson<String>(json['contentType']),
      fileUri: serializer.fromJson<String?>(json['fileUri']),
      fileSize: serializer.fromJson<int?>(json['fileSize']),
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
      'textarea': serializer.toJson<String?>(textarea),
      'role': serializer.toJson<String>(role),
      'contentType': serializer.toJson<String>(contentType),
      'fileUri': serializer.toJson<String?>(fileUri),
      'fileSize': serializer.toJson<int?>(fileSize),
      'datetime': serializer.toJson<DateTime>(datetime),
    };
  }

  ChatContentTableDataData copyWith(
          {int? id,
          int? parentid,
          String? title,
          Value<String?> textarea = const Value.absent(),
          String? role,
          String? contentType,
          Value<String?> fileUri = const Value.absent(),
          Value<int?> fileSize = const Value.absent(),
          DateTime? datetime}) =>
      ChatContentTableDataData(
        id: id ?? this.id,
        parentid: parentid ?? this.parentid,
        title: title ?? this.title,
        textarea: textarea.present ? textarea.value : this.textarea,
        role: role ?? this.role,
        contentType: contentType ?? this.contentType,
        fileUri: fileUri.present ? fileUri.value : this.fileUri,
        fileSize: fileSize.present ? fileSize.value : this.fileSize,
        datetime: datetime ?? this.datetime,
      );
  ChatContentTableDataData copyWithCompanion(
      ChatContentTableDataCompanion data) {
    return ChatContentTableDataData(
      id: data.id.present ? data.id.value : this.id,
      parentid: data.parentid.present ? data.parentid.value : this.parentid,
      title: data.title.present ? data.title.value : this.title,
      textarea: data.textarea.present ? data.textarea.value : this.textarea,
      role: data.role.present ? data.role.value : this.role,
      contentType:
          data.contentType.present ? data.contentType.value : this.contentType,
      fileUri: data.fileUri.present ? data.fileUri.value : this.fileUri,
      fileSize: data.fileSize.present ? data.fileSize.value : this.fileSize,
      datetime: data.datetime.present ? data.datetime.value : this.datetime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatContentTableDataData(')
          ..write('id: $id, ')
          ..write('parentid: $parentid, ')
          ..write('title: $title, ')
          ..write('textarea: $textarea, ')
          ..write('role: $role, ')
          ..write('contentType: $contentType, ')
          ..write('fileUri: $fileUri, ')
          ..write('fileSize: $fileSize, ')
          ..write('datetime: $datetime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, parentid, title, textarea, role,
      contentType, fileUri, fileSize, datetime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatContentTableDataData &&
          other.id == this.id &&
          other.parentid == this.parentid &&
          other.title == this.title &&
          other.textarea == this.textarea &&
          other.role == this.role &&
          other.contentType == this.contentType &&
          other.fileUri == this.fileUri &&
          other.fileSize == this.fileSize &&
          other.datetime == this.datetime);
}

class ChatContentTableDataCompanion
    extends UpdateCompanion<ChatContentTableDataData> {
  final Value<int> id;
  final Value<int> parentid;
  final Value<String> title;
  final Value<String?> textarea;
  final Value<String> role;
  final Value<String> contentType;
  final Value<String?> fileUri;
  final Value<int?> fileSize;
  final Value<DateTime> datetime;
  const ChatContentTableDataCompanion({
    this.id = const Value.absent(),
    this.parentid = const Value.absent(),
    this.title = const Value.absent(),
    this.textarea = const Value.absent(),
    this.role = const Value.absent(),
    this.contentType = const Value.absent(),
    this.fileUri = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.datetime = const Value.absent(),
  });
  ChatContentTableDataCompanion.insert({
    this.id = const Value.absent(),
    required int parentid,
    required String title,
    this.textarea = const Value.absent(),
    required String role,
    required String contentType,
    this.fileUri = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.datetime = const Value.absent(),
  })  : parentid = Value(parentid),
        title = Value(title),
        role = Value(role),
        contentType = Value(contentType);
  static Insertable<ChatContentTableDataData> custom({
    Expression<int>? id,
    Expression<int>? parentid,
    Expression<String>? title,
    Expression<String>? textarea,
    Expression<String>? role,
    Expression<String>? contentType,
    Expression<String>? fileUri,
    Expression<int>? fileSize,
    Expression<DateTime>? datetime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parentid != null) 'parentid': parentid,
      if (title != null) 'title': title,
      if (textarea != null) 'textarea': textarea,
      if (role != null) 'role': role,
      if (contentType != null) 'content_type': contentType,
      if (fileUri != null) 'file_uri': fileUri,
      if (fileSize != null) 'file_size': fileSize,
      if (datetime != null) 'datetime': datetime,
    });
  }

  ChatContentTableDataCompanion copyWith(
      {Value<int>? id,
      Value<int>? parentid,
      Value<String>? title,
      Value<String?>? textarea,
      Value<String>? role,
      Value<String>? contentType,
      Value<String?>? fileUri,
      Value<int?>? fileSize,
      Value<DateTime>? datetime}) {
    return ChatContentTableDataCompanion(
      id: id ?? this.id,
      parentid: parentid ?? this.parentid,
      title: title ?? this.title,
      textarea: textarea ?? this.textarea,
      role: role ?? this.role,
      contentType: contentType ?? this.contentType,
      fileUri: fileUri ?? this.fileUri,
      fileSize: fileSize ?? this.fileSize,
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
    if (textarea.present) {
      map['textarea'] = Variable<String>(textarea.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (fileUri.present) {
      map['file_uri'] = Variable<String>(fileUri.value);
    }
    if (fileSize.present) {
      map['file_size'] = Variable<int>(fileSize.value);
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
          ..write('textarea: $textarea, ')
          ..write('role: $role, ')
          ..write('contentType: $contentType, ')
          ..write('fileUri: $fileUri, ')
          ..write('fileSize: $fileSize, ')
          ..write('datetime: $datetime')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
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

typedef $$ChatTableDataTableCreateCompanionBuilder = ChatTableDataCompanion
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

class $$ChatTableDataTableFilterComposer
    extends Composer<_$AppDatabase, $ChatTableDataTable> {
  $$ChatTableDataTableFilterComposer({
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

  ColumnFilters<bool> get isupdate => $composableBuilder(
      column: $table.isupdate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get datetime => $composableBuilder(
      column: $table.datetime, builder: (column) => ColumnFilters(column));
}

class $$ChatTableDataTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatTableDataTable> {
  $$ChatTableDataTableOrderingComposer({
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

  ColumnOrderings<bool> get isupdate => $composableBuilder(
      column: $table.isupdate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get datetime => $composableBuilder(
      column: $table.datetime, builder: (column) => ColumnOrderings(column));
}

class $$ChatTableDataTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatTableDataTable> {
  $$ChatTableDataTableAnnotationComposer({
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

  GeneratedColumn<bool> get isupdate =>
      $composableBuilder(column: $table.isupdate, builder: (column) => column);

  GeneratedColumn<DateTime> get datetime =>
      $composableBuilder(column: $table.datetime, builder: (column) => column);
}

class $$ChatTableDataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatTableDataTable,
    ChatTableDataData,
    $$ChatTableDataTableFilterComposer,
    $$ChatTableDataTableOrderingComposer,
    $$ChatTableDataTableAnnotationComposer,
    $$ChatTableDataTableCreateCompanionBuilder,
    $$ChatTableDataTableUpdateCompanionBuilder,
    (
      ChatTableDataData,
      BaseReferences<_$AppDatabase, $ChatTableDataTable, ChatTableDataData>
    ),
    ChatTableDataData,
    PrefetchHooks Function()> {
  $$ChatTableDataTableTableManager(_$AppDatabase db, $ChatTableDataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatTableDataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatTableDataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatTableDataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
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
          createCompanionCallback: ({
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
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChatTableDataTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChatTableDataTable,
    ChatTableDataData,
    $$ChatTableDataTableFilterComposer,
    $$ChatTableDataTableOrderingComposer,
    $$ChatTableDataTableAnnotationComposer,
    $$ChatTableDataTableCreateCompanionBuilder,
    $$ChatTableDataTableUpdateCompanionBuilder,
    (
      ChatTableDataData,
      BaseReferences<_$AppDatabase, $ChatTableDataTable, ChatTableDataData>
    ),
    ChatTableDataData,
    PrefetchHooks Function()>;
typedef $$ChatContentTableDataTableCreateCompanionBuilder
    = ChatContentTableDataCompanion Function({
  Value<int> id,
  required int parentid,
  required String title,
  Value<String?> textarea,
  required String role,
  required String contentType,
  Value<String?> fileUri,
  Value<int?> fileSize,
  Value<DateTime> datetime,
});
typedef $$ChatContentTableDataTableUpdateCompanionBuilder
    = ChatContentTableDataCompanion Function({
  Value<int> id,
  Value<int> parentid,
  Value<String> title,
  Value<String?> textarea,
  Value<String> role,
  Value<String> contentType,
  Value<String?> fileUri,
  Value<int?> fileSize,
  Value<DateTime> datetime,
});

class $$ChatContentTableDataTableFilterComposer
    extends Composer<_$AppDatabase, $ChatContentTableDataTable> {
  $$ChatContentTableDataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get parentid => $composableBuilder(
      column: $table.parentid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textarea => $composableBuilder(
      column: $table.textarea, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentType => $composableBuilder(
      column: $table.contentType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fileUri => $composableBuilder(
      column: $table.fileUri, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fileSize => $composableBuilder(
      column: $table.fileSize, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get datetime => $composableBuilder(
      column: $table.datetime, builder: (column) => ColumnFilters(column));
}

class $$ChatContentTableDataTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatContentTableDataTable> {
  $$ChatContentTableDataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get parentid => $composableBuilder(
      column: $table.parentid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textarea => $composableBuilder(
      column: $table.textarea, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentType => $composableBuilder(
      column: $table.contentType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fileUri => $composableBuilder(
      column: $table.fileUri, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fileSize => $composableBuilder(
      column: $table.fileSize, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get datetime => $composableBuilder(
      column: $table.datetime, builder: (column) => ColumnOrderings(column));
}

class $$ChatContentTableDataTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatContentTableDataTable> {
  $$ChatContentTableDataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get parentid =>
      $composableBuilder(column: $table.parentid, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get textarea =>
      $composableBuilder(column: $table.textarea, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get contentType => $composableBuilder(
      column: $table.contentType, builder: (column) => column);

  GeneratedColumn<String> get fileUri =>
      $composableBuilder(column: $table.fileUri, builder: (column) => column);

  GeneratedColumn<int> get fileSize =>
      $composableBuilder(column: $table.fileSize, builder: (column) => column);

  GeneratedColumn<DateTime> get datetime =>
      $composableBuilder(column: $table.datetime, builder: (column) => column);
}

class $$ChatContentTableDataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatContentTableDataTable,
    ChatContentTableDataData,
    $$ChatContentTableDataTableFilterComposer,
    $$ChatContentTableDataTableOrderingComposer,
    $$ChatContentTableDataTableAnnotationComposer,
    $$ChatContentTableDataTableCreateCompanionBuilder,
    $$ChatContentTableDataTableUpdateCompanionBuilder,
    (
      ChatContentTableDataData,
      BaseReferences<_$AppDatabase, $ChatContentTableDataTable,
          ChatContentTableDataData>
    ),
    ChatContentTableDataData,
    PrefetchHooks Function()> {
  $$ChatContentTableDataTableTableManager(
      _$AppDatabase db, $ChatContentTableDataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatContentTableDataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatContentTableDataTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatContentTableDataTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> parentid = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> textarea = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String> contentType = const Value.absent(),
            Value<String?> fileUri = const Value.absent(),
            Value<int?> fileSize = const Value.absent(),
            Value<DateTime> datetime = const Value.absent(),
          }) =>
              ChatContentTableDataCompanion(
            id: id,
            parentid: parentid,
            title: title,
            textarea: textarea,
            role: role,
            contentType: contentType,
            fileUri: fileUri,
            fileSize: fileSize,
            datetime: datetime,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int parentid,
            required String title,
            Value<String?> textarea = const Value.absent(),
            required String role,
            required String contentType,
            Value<String?> fileUri = const Value.absent(),
            Value<int?> fileSize = const Value.absent(),
            Value<DateTime> datetime = const Value.absent(),
          }) =>
              ChatContentTableDataCompanion.insert(
            id: id,
            parentid: parentid,
            title: title,
            textarea: textarea,
            role: role,
            contentType: contentType,
            fileUri: fileUri,
            fileSize: fileSize,
            datetime: datetime,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChatContentTableDataTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ChatContentTableDataTable,
        ChatContentTableDataData,
        $$ChatContentTableDataTableFilterComposer,
        $$ChatContentTableDataTableOrderingComposer,
        $$ChatContentTableDataTableAnnotationComposer,
        $$ChatContentTableDataTableCreateCompanionBuilder,
        $$ChatContentTableDataTableUpdateCompanionBuilder,
        (
          ChatContentTableDataData,
          BaseReferences<_$AppDatabase, $ChatContentTableDataTable,
              ChatContentTableDataData>
        ),
        ChatContentTableDataData,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ChatTableDataTableTableManager get chatTableData =>
      $$ChatTableDataTableTableManager(_db, _db.chatTableData);
  $$ChatContentTableDataTableTableManager get chatContentTableData =>
      $$ChatContentTableDataTableTableManager(_db, _db.chatContentTableData);
}
