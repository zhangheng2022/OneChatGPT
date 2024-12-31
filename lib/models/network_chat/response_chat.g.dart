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
    object: json['object'] as String,
    created: (json['created'] as num).toInt(),
    model: json['model'] as String,
    imageData: json['imageData'] as String?,
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
      'imageData': instance.imageData,
      'choices': instance.choices,
    };

Choice _$ChoiceFromJson(Map<String, dynamic> json) => Choice(
      finishReason: json['finish_reason'] as String?,
      index: (json['index'] as num).toInt(),
      message: json['message'] == null
          ? null
          : MessageOrDelta.fromJson(json['message'] as Map<String, dynamic>),
      delta: json['delta'] == null
          ? null
          : MessageOrDelta.fromJson(json['delta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChoiceToJson(Choice instance) => <String, dynamic>{
      'index': instance.index,
      'finish_reason': instance.finishReason,
      'message': instance.message,
      'delta': instance.delta,
    };

MessageOrDelta _$MessageOrDeltaFromJson(Map<String, dynamic> json) =>
    MessageOrDelta(
      content: json['content'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$MessageOrDeltaToJson(MessageOrDelta instance) =>
    <String, dynamic>{
      'content': instance.content,
      'role': instance.role,
    };
