// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id'],
  );
  return ChatMessage(
    id: json['id'] as String,
    object: json['object'] as String,
    created: (json['created'] as num).toInt(),
    model: json['model'] as String,
    choices: (json['choices'] as List<dynamic>)
        .map((e) => ChatMessageChoice.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created': instance.created,
      'model': instance.model,
      'choices': instance.choices,
    };

ChatMessageChoice _$ChatMessageChoiceFromJson(Map<String, dynamic> json) =>
    ChatMessageChoice(
      index: (json['index'] as num).toInt(),
      delta: ChatMessageDelta.fromJson(json['delta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatMessageChoiceToJson(ChatMessageChoice instance) =>
    <String, dynamic>{
      'index': instance.index,
      'delta': instance.delta,
    };

ChatMessageDelta _$ChatMessageDeltaFromJson(Map<String, dynamic> json) =>
    ChatMessageDelta(
      content: json['content'] as String,
    );

Map<String, dynamic> _$ChatMessageDeltaToJson(ChatMessageDelta instance) =>
    <String, dynamic>{
      'content': instance.content,
    };
