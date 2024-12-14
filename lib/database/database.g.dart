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
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant("新的对话"));
  static const VerificationMeta _autoTitleMeta =
      const VerificationMeta('autoTitle');
  @override
  late final GeneratedColumn<bool> autoTitle = GeneratedColumn<bool>(
      'auto_title', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("auto_title" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _datetimeMeta =
      const VerificationMeta('datetime');
  @override
  late final GeneratedColumn<DateTime> datetime = GeneratedColumn<DateTime>(
      'datetime', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _presetMeta = const VerificationMeta('preset');
  @override
  late final GeneratedColumnWithTypeConverter<PresetEnum, String> preset =
      GeneratedColumn<String>('preset', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: Constant("comprehensive"))
          .withConverter<PresetEnum>($ChatTableDataTable.$converterpreset);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, autoTitle, datetime, preset];
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
    if (data.containsKey('auto_title')) {
      context.handle(_autoTitleMeta,
          autoTitle.isAcceptableOrUnknown(data['auto_title']!, _autoTitleMeta));
    }
    if (data.containsKey('datetime')) {
      context.handle(_datetimeMeta,
          datetime.isAcceptableOrUnknown(data['datetime']!, _datetimeMeta));
    }
    context.handle(_presetMeta, const VerificationResult.success());
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
      autoTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}auto_title'])!,
      datetime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}datetime'])!,
      preset: $ChatTableDataTable.$converterpreset.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}preset'])!),
    );
  }

  @override
  $ChatTableDataTable createAlias(String alias) {
    return $ChatTableDataTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PresetEnum, String, String> $converterpreset =
      const EnumNameConverter<PresetEnum>(PresetEnum.values);
}

class ChatTableDataData extends DataClass
    implements Insertable<ChatTableDataData> {
  final int id;
  final String title;
  final bool autoTitle;
  final DateTime datetime;
  final PresetEnum preset;
  const ChatTableDataData(
      {required this.id,
      required this.title,
      required this.autoTitle,
      required this.datetime,
      required this.preset});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['auto_title'] = Variable<bool>(autoTitle);
    map['datetime'] = Variable<DateTime>(datetime);
    {
      map['preset'] =
          Variable<String>($ChatTableDataTable.$converterpreset.toSql(preset));
    }
    return map;
  }

  ChatTableDataCompanion toCompanion(bool nullToAbsent) {
    return ChatTableDataCompanion(
      id: Value(id),
      title: Value(title),
      autoTitle: Value(autoTitle),
      datetime: Value(datetime),
      preset: Value(preset),
    );
  }

  factory ChatTableDataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatTableDataData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      autoTitle: serializer.fromJson<bool>(json['autoTitle']),
      datetime: serializer.fromJson<DateTime>(json['datetime']),
      preset: $ChatTableDataTable.$converterpreset
          .fromJson(serializer.fromJson<String>(json['preset'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'autoTitle': serializer.toJson<bool>(autoTitle),
      'datetime': serializer.toJson<DateTime>(datetime),
      'preset': serializer
          .toJson<String>($ChatTableDataTable.$converterpreset.toJson(preset)),
    };
  }

  ChatTableDataData copyWith(
          {int? id,
          String? title,
          bool? autoTitle,
          DateTime? datetime,
          PresetEnum? preset}) =>
      ChatTableDataData(
        id: id ?? this.id,
        title: title ?? this.title,
        autoTitle: autoTitle ?? this.autoTitle,
        datetime: datetime ?? this.datetime,
        preset: preset ?? this.preset,
      );
  ChatTableDataData copyWithCompanion(ChatTableDataCompanion data) {
    return ChatTableDataData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      autoTitle: data.autoTitle.present ? data.autoTitle.value : this.autoTitle,
      datetime: data.datetime.present ? data.datetime.value : this.datetime,
      preset: data.preset.present ? data.preset.value : this.preset,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatTableDataData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('autoTitle: $autoTitle, ')
          ..write('datetime: $datetime, ')
          ..write('preset: $preset')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, autoTitle, datetime, preset);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatTableDataData &&
          other.id == this.id &&
          other.title == this.title &&
          other.autoTitle == this.autoTitle &&
          other.datetime == this.datetime &&
          other.preset == this.preset);
}

class ChatTableDataCompanion extends UpdateCompanion<ChatTableDataData> {
  final Value<int> id;
  final Value<String> title;
  final Value<bool> autoTitle;
  final Value<DateTime> datetime;
  final Value<PresetEnum> preset;
  const ChatTableDataCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.autoTitle = const Value.absent(),
    this.datetime = const Value.absent(),
    this.preset = const Value.absent(),
  });
  ChatTableDataCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.autoTitle = const Value.absent(),
    this.datetime = const Value.absent(),
    this.preset = const Value.absent(),
  });
  static Insertable<ChatTableDataData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<bool>? autoTitle,
    Expression<DateTime>? datetime,
    Expression<String>? preset,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (autoTitle != null) 'auto_title': autoTitle,
      if (datetime != null) 'datetime': datetime,
      if (preset != null) 'preset': preset,
    });
  }

  ChatTableDataCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<bool>? autoTitle,
      Value<DateTime>? datetime,
      Value<PresetEnum>? preset}) {
    return ChatTableDataCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      autoTitle: autoTitle ?? this.autoTitle,
      datetime: datetime ?? this.datetime,
      preset: preset ?? this.preset,
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
    if (autoTitle.present) {
      map['auto_title'] = Variable<bool>(autoTitle.value);
    }
    if (datetime.present) {
      map['datetime'] = Variable<DateTime>(datetime.value);
    }
    if (preset.present) {
      map['preset'] = Variable<String>(
          $ChatTableDataTable.$converterpreset.toSql(preset.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatTableDataCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('autoTitle: $autoTitle, ')
          ..write('datetime: $datetime, ')
          ..write('preset: $preset')
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
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contentTypeMeta =
      const VerificationMeta('contentType');
  @override
  late final GeneratedColumnWithTypeConverter<ContentTypeEnum, String>
      contentType = GeneratedColumn<String>('content_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<ContentTypeEnum>(
              $ChatContentTableDataTable.$convertercontentType);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumnWithTypeConverter<RoleEnum, String> role =
      GeneratedColumn<String>('role', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<RoleEnum>($ChatContentTableDataTable.$converterrole);
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
  static const VerificationMeta _presetMeta = const VerificationMeta('preset');
  @override
  late final GeneratedColumnWithTypeConverter<PresetEnum, String> preset =
      GeneratedColumn<String>('preset', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: Constant(PresetEnum.comprehensive.toString()))
          .withConverter<PresetEnum>(
              $ChatContentTableDataTable.$converterpreset);
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
        content,
        contentType,
        role,
        fileUri,
        fileSize,
        preset,
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
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    context.handle(_contentTypeMeta, const VerificationResult.success());
    context.handle(_roleMeta, const VerificationResult.success());
    if (data.containsKey('file_uri')) {
      context.handle(_fileUriMeta,
          fileUri.isAcceptableOrUnknown(data['file_uri']!, _fileUriMeta));
    }
    if (data.containsKey('file_size')) {
      context.handle(_fileSizeMeta,
          fileSize.isAcceptableOrUnknown(data['file_size']!, _fileSizeMeta));
    }
    context.handle(_presetMeta, const VerificationResult.success());
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
          .read(DriftSqlType.string, data['${effectivePrefix}content']),
      contentType: $ChatContentTableDataTable.$convertercontentType.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}content_type'])!),
      role: $ChatContentTableDataTable.$converterrole.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!),
      fileUri: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_uri']),
      fileSize: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}file_size']),
      preset: $ChatContentTableDataTable.$converterpreset.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}preset'])!),
      datetime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}datetime'])!,
    );
  }

  @override
  $ChatContentTableDataTable createAlias(String alias) {
    return $ChatContentTableDataTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ContentTypeEnum, String, String>
      $convertercontentType =
      const EnumNameConverter<ContentTypeEnum>(ContentTypeEnum.values);
  static JsonTypeConverter2<RoleEnum, String, String> $converterrole =
      const EnumNameConverter<RoleEnum>(RoleEnum.values);
  static JsonTypeConverter2<PresetEnum, String, String> $converterpreset =
      const EnumNameConverter<PresetEnum>(PresetEnum.values);
}

class ChatContentTableDataData extends DataClass
    implements Insertable<ChatContentTableDataData> {
  final int id;
  final int parentid;
  final String title;
  final String? content;
  final ContentTypeEnum contentType;
  final RoleEnum role;
  final String? fileUri;
  final int? fileSize;
  final PresetEnum preset;
  final DateTime datetime;
  const ChatContentTableDataData(
      {required this.id,
      required this.parentid,
      required this.title,
      this.content,
      required this.contentType,
      required this.role,
      this.fileUri,
      this.fileSize,
      required this.preset,
      required this.datetime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['parentid'] = Variable<int>(parentid);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    {
      map['content_type'] = Variable<String>(
          $ChatContentTableDataTable.$convertercontentType.toSql(contentType));
    }
    {
      map['role'] = Variable<String>(
          $ChatContentTableDataTable.$converterrole.toSql(role));
    }
    if (!nullToAbsent || fileUri != null) {
      map['file_uri'] = Variable<String>(fileUri);
    }
    if (!nullToAbsent || fileSize != null) {
      map['file_size'] = Variable<int>(fileSize);
    }
    {
      map['preset'] = Variable<String>(
          $ChatContentTableDataTable.$converterpreset.toSql(preset));
    }
    map['datetime'] = Variable<DateTime>(datetime);
    return map;
  }

  ChatContentTableDataCompanion toCompanion(bool nullToAbsent) {
    return ChatContentTableDataCompanion(
      id: Value(id),
      parentid: Value(parentid),
      title: Value(title),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      contentType: Value(contentType),
      role: Value(role),
      fileUri: fileUri == null && nullToAbsent
          ? const Value.absent()
          : Value(fileUri),
      fileSize: fileSize == null && nullToAbsent
          ? const Value.absent()
          : Value(fileSize),
      preset: Value(preset),
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
      content: serializer.fromJson<String?>(json['content']),
      contentType: $ChatContentTableDataTable.$convertercontentType
          .fromJson(serializer.fromJson<String>(json['contentType'])),
      role: $ChatContentTableDataTable.$converterrole
          .fromJson(serializer.fromJson<String>(json['role'])),
      fileUri: serializer.fromJson<String?>(json['fileUri']),
      fileSize: serializer.fromJson<int?>(json['fileSize']),
      preset: $ChatContentTableDataTable.$converterpreset
          .fromJson(serializer.fromJson<String>(json['preset'])),
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
      'content': serializer.toJson<String?>(content),
      'contentType': serializer.toJson<String>(
          $ChatContentTableDataTable.$convertercontentType.toJson(contentType)),
      'role': serializer.toJson<String>(
          $ChatContentTableDataTable.$converterrole.toJson(role)),
      'fileUri': serializer.toJson<String?>(fileUri),
      'fileSize': serializer.toJson<int?>(fileSize),
      'preset': serializer.toJson<String>(
          $ChatContentTableDataTable.$converterpreset.toJson(preset)),
      'datetime': serializer.toJson<DateTime>(datetime),
    };
  }

  ChatContentTableDataData copyWith(
          {int? id,
          int? parentid,
          String? title,
          Value<String?> content = const Value.absent(),
          ContentTypeEnum? contentType,
          RoleEnum? role,
          Value<String?> fileUri = const Value.absent(),
          Value<int?> fileSize = const Value.absent(),
          PresetEnum? preset,
          DateTime? datetime}) =>
      ChatContentTableDataData(
        id: id ?? this.id,
        parentid: parentid ?? this.parentid,
        title: title ?? this.title,
        content: content.present ? content.value : this.content,
        contentType: contentType ?? this.contentType,
        role: role ?? this.role,
        fileUri: fileUri.present ? fileUri.value : this.fileUri,
        fileSize: fileSize.present ? fileSize.value : this.fileSize,
        preset: preset ?? this.preset,
        datetime: datetime ?? this.datetime,
      );
  ChatContentTableDataData copyWithCompanion(
      ChatContentTableDataCompanion data) {
    return ChatContentTableDataData(
      id: data.id.present ? data.id.value : this.id,
      parentid: data.parentid.present ? data.parentid.value : this.parentid,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      contentType:
          data.contentType.present ? data.contentType.value : this.contentType,
      role: data.role.present ? data.role.value : this.role,
      fileUri: data.fileUri.present ? data.fileUri.value : this.fileUri,
      fileSize: data.fileSize.present ? data.fileSize.value : this.fileSize,
      preset: data.preset.present ? data.preset.value : this.preset,
      datetime: data.datetime.present ? data.datetime.value : this.datetime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatContentTableDataData(')
          ..write('id: $id, ')
          ..write('parentid: $parentid, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('contentType: $contentType, ')
          ..write('role: $role, ')
          ..write('fileUri: $fileUri, ')
          ..write('fileSize: $fileSize, ')
          ..write('preset: $preset, ')
          ..write('datetime: $datetime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, parentid, title, content, contentType,
      role, fileUri, fileSize, preset, datetime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatContentTableDataData &&
          other.id == this.id &&
          other.parentid == this.parentid &&
          other.title == this.title &&
          other.content == this.content &&
          other.contentType == this.contentType &&
          other.role == this.role &&
          other.fileUri == this.fileUri &&
          other.fileSize == this.fileSize &&
          other.preset == this.preset &&
          other.datetime == this.datetime);
}

class ChatContentTableDataCompanion
    extends UpdateCompanion<ChatContentTableDataData> {
  final Value<int> id;
  final Value<int> parentid;
  final Value<String> title;
  final Value<String?> content;
  final Value<ContentTypeEnum> contentType;
  final Value<RoleEnum> role;
  final Value<String?> fileUri;
  final Value<int?> fileSize;
  final Value<PresetEnum> preset;
  final Value<DateTime> datetime;
  const ChatContentTableDataCompanion({
    this.id = const Value.absent(),
    this.parentid = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.contentType = const Value.absent(),
    this.role = const Value.absent(),
    this.fileUri = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.preset = const Value.absent(),
    this.datetime = const Value.absent(),
  });
  ChatContentTableDataCompanion.insert({
    this.id = const Value.absent(),
    required int parentid,
    required String title,
    this.content = const Value.absent(),
    required ContentTypeEnum contentType,
    required RoleEnum role,
    this.fileUri = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.preset = const Value.absent(),
    this.datetime = const Value.absent(),
  })  : parentid = Value(parentid),
        title = Value(title),
        contentType = Value(contentType),
        role = Value(role);
  static Insertable<ChatContentTableDataData> custom({
    Expression<int>? id,
    Expression<int>? parentid,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? contentType,
    Expression<String>? role,
    Expression<String>? fileUri,
    Expression<int>? fileSize,
    Expression<String>? preset,
    Expression<DateTime>? datetime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parentid != null) 'parentid': parentid,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (contentType != null) 'content_type': contentType,
      if (role != null) 'role': role,
      if (fileUri != null) 'file_uri': fileUri,
      if (fileSize != null) 'file_size': fileSize,
      if (preset != null) 'preset': preset,
      if (datetime != null) 'datetime': datetime,
    });
  }

  ChatContentTableDataCompanion copyWith(
      {Value<int>? id,
      Value<int>? parentid,
      Value<String>? title,
      Value<String?>? content,
      Value<ContentTypeEnum>? contentType,
      Value<RoleEnum>? role,
      Value<String?>? fileUri,
      Value<int?>? fileSize,
      Value<PresetEnum>? preset,
      Value<DateTime>? datetime}) {
    return ChatContentTableDataCompanion(
      id: id ?? this.id,
      parentid: parentid ?? this.parentid,
      title: title ?? this.title,
      content: content ?? this.content,
      contentType: contentType ?? this.contentType,
      role: role ?? this.role,
      fileUri: fileUri ?? this.fileUri,
      fileSize: fileSize ?? this.fileSize,
      preset: preset ?? this.preset,
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
      map['content_type'] = Variable<String>($ChatContentTableDataTable
          .$convertercontentType
          .toSql(contentType.value));
    }
    if (role.present) {
      map['role'] = Variable<String>(
          $ChatContentTableDataTable.$converterrole.toSql(role.value));
    }
    if (fileUri.present) {
      map['file_uri'] = Variable<String>(fileUri.value);
    }
    if (fileSize.present) {
      map['file_size'] = Variable<int>(fileSize.value);
    }
    if (preset.present) {
      map['preset'] = Variable<String>(
          $ChatContentTableDataTable.$converterpreset.toSql(preset.value));
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
          ..write('role: $role, ')
          ..write('fileUri: $fileUri, ')
          ..write('fileSize: $fileSize, ')
          ..write('preset: $preset, ')
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
  Value<bool> autoTitle,
  Value<DateTime> datetime,
  Value<PresetEnum> preset,
});
typedef $$ChatTableDataTableUpdateCompanionBuilder = ChatTableDataCompanion
    Function({
  Value<int> id,
  Value<String> title,
  Value<bool> autoTitle,
  Value<DateTime> datetime,
  Value<PresetEnum> preset,
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

  ColumnFilters<bool> get autoTitle => $composableBuilder(
      column: $table.autoTitle, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get datetime => $composableBuilder(
      column: $table.datetime, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<PresetEnum, PresetEnum, String> get preset =>
      $composableBuilder(
          column: $table.preset,
          builder: (column) => ColumnWithTypeConverterFilters(column));
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

  ColumnOrderings<bool> get autoTitle => $composableBuilder(
      column: $table.autoTitle, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get datetime => $composableBuilder(
      column: $table.datetime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get preset => $composableBuilder(
      column: $table.preset, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<bool> get autoTitle =>
      $composableBuilder(column: $table.autoTitle, builder: (column) => column);

  GeneratedColumn<DateTime> get datetime =>
      $composableBuilder(column: $table.datetime, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PresetEnum, String> get preset =>
      $composableBuilder(column: $table.preset, builder: (column) => column);
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
            Value<bool> autoTitle = const Value.absent(),
            Value<DateTime> datetime = const Value.absent(),
            Value<PresetEnum> preset = const Value.absent(),
          }) =>
              ChatTableDataCompanion(
            id: id,
            title: title,
            autoTitle: autoTitle,
            datetime: datetime,
            preset: preset,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<bool> autoTitle = const Value.absent(),
            Value<DateTime> datetime = const Value.absent(),
            Value<PresetEnum> preset = const Value.absent(),
          }) =>
              ChatTableDataCompanion.insert(
            id: id,
            title: title,
            autoTitle: autoTitle,
            datetime: datetime,
            preset: preset,
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
  Value<String?> content,
  required ContentTypeEnum contentType,
  required RoleEnum role,
  Value<String?> fileUri,
  Value<int?> fileSize,
  Value<PresetEnum> preset,
  Value<DateTime> datetime,
});
typedef $$ChatContentTableDataTableUpdateCompanionBuilder
    = ChatContentTableDataCompanion Function({
  Value<int> id,
  Value<int> parentid,
  Value<String> title,
  Value<String?> content,
  Value<ContentTypeEnum> contentType,
  Value<RoleEnum> role,
  Value<String?> fileUri,
  Value<int?> fileSize,
  Value<PresetEnum> preset,
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

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ContentTypeEnum, ContentTypeEnum, String>
      get contentType => $composableBuilder(
          column: $table.contentType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<RoleEnum, RoleEnum, String> get role =>
      $composableBuilder(
          column: $table.role,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get fileUri => $composableBuilder(
      column: $table.fileUri, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fileSize => $composableBuilder(
      column: $table.fileSize, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<PresetEnum, PresetEnum, String> get preset =>
      $composableBuilder(
          column: $table.preset,
          builder: (column) => ColumnWithTypeConverterFilters(column));

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

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentType => $composableBuilder(
      column: $table.contentType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fileUri => $composableBuilder(
      column: $table.fileUri, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fileSize => $composableBuilder(
      column: $table.fileSize, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get preset => $composableBuilder(
      column: $table.preset, builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ContentTypeEnum, String> get contentType =>
      $composableBuilder(
          column: $table.contentType, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RoleEnum, String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get fileUri =>
      $composableBuilder(column: $table.fileUri, builder: (column) => column);

  GeneratedColumn<int> get fileSize =>
      $composableBuilder(column: $table.fileSize, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PresetEnum, String> get preset =>
      $composableBuilder(column: $table.preset, builder: (column) => column);

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
            Value<String?> content = const Value.absent(),
            Value<ContentTypeEnum> contentType = const Value.absent(),
            Value<RoleEnum> role = const Value.absent(),
            Value<String?> fileUri = const Value.absent(),
            Value<int?> fileSize = const Value.absent(),
            Value<PresetEnum> preset = const Value.absent(),
            Value<DateTime> datetime = const Value.absent(),
          }) =>
              ChatContentTableDataCompanion(
            id: id,
            parentid: parentid,
            title: title,
            content: content,
            contentType: contentType,
            role: role,
            fileUri: fileUri,
            fileSize: fileSize,
            preset: preset,
            datetime: datetime,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int parentid,
            required String title,
            Value<String?> content = const Value.absent(),
            required ContentTypeEnum contentType,
            required RoleEnum role,
            Value<String?> fileUri = const Value.absent(),
            Value<int?> fileSize = const Value.absent(),
            Value<PresetEnum> preset = const Value.absent(),
            Value<DateTime> datetime = const Value.absent(),
          }) =>
              ChatContentTableDataCompanion.insert(
            id: id,
            parentid: parentid,
            title: title,
            content: content,
            contentType: contentType,
            role: role,
            fileUri: fileUri,
            fileSize: fileSize,
            preset: preset,
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
