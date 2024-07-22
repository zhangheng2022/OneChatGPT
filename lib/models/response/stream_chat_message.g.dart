// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreamChatMessage _$StreamChatMessageFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id'],
  );
  return StreamChatMessage(
    id: json['id'] as String,
    object: json['object'] as String?,
    created: (json['created'] as num).toInt(),
    model: json['model'] as String,
    choices: (json['choices'] as List<dynamic>)
        .map((e) => StreamChatMessageChoice.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$StreamChatMessageToJson(StreamChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created': instance.created,
      'model': instance.model,
      'choices': instance.choices,
    };

StreamChatMessageChoice _$StreamChatMessageChoiceFromJson(
        Map<String, dynamic> json) =>
    StreamChatMessageChoice(
      index: (json['index'] as num).toInt(),
      delta: StreamChatMessageDelta.fromJson(
          json['delta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StreamChatMessageChoiceToJson(
        StreamChatMessageChoice instance) =>
    <String, dynamic>{
      'index': instance.index,
      'delta': instance.delta,
    };

StreamChatMessageDelta _$StreamChatMessageDeltaFromJson(
        Map<String, dynamic> json) =>
    StreamChatMessageDelta(
      content: json['content'] as String,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$StreamChatMessageDeltaToJson(
        StreamChatMessageDelta instance) =>
    <String, dynamic>{
      'content': instance.content,
      'role': instance.role,
    };
