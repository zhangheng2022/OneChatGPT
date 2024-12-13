// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseChat _$ResponseChatFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id'],
  );
  return ResponseChat(
    id: json['id'] as String,
    object: json['object'] as String?,
    created: (json['created'] as num).toInt(),
    model: json['model'] as String,
    choices: (json['choices'] as List<dynamic>)
        .map((e) => Choice.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ResponseChatToJson(ResponseChat instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created': instance.created,
      'model': instance.model,
      'choices': instance.choices,
    };

Choice _$ChoiceFromJson(Map<String, dynamic> json) => Choice(
      index: (json['index'] as num).toInt(),
      delta: Delta.fromJson(json['delta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChoiceToJson(Choice instance) => <String, dynamic>{
      'index': instance.index,
      'delta': instance.delta,
    };

Delta _$DeltaFromJson(Map<String, dynamic> json) => Delta(
      content: json['content'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$DeltaToJson(Delta instance) => <String, dynamic>{
      'content': instance.content,
      'role': instance.role,
    };
