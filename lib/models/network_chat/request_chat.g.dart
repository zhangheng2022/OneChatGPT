// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestChat _$RequestChatFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['model'],
  );
  return RequestChat(
    messages: (json['messages'] as List<dynamic>)
        .map((e) => RequestChatMessage.fromJson(e as Map<String, dynamic>))
        .toList(),
    model: json['model'] as String,
    maxTokens: (json['maxTokens'] as num?)?.toInt(),
    temperature: (json['temperature'] as num?)?.toDouble(),
    topP: (json['topP'] as num?)?.toDouble(),
    historyMessages: (json['historyMessages'] as num?)?.toDouble(),
    autoTitle: json['autoTitle'] as bool?,
  );
}

Map<String, dynamic> _$RequestChatToJson(RequestChat instance) =>
    <String, dynamic>{
      'maxTokens': instance.maxTokens,
      'temperature': instance.temperature,
      'topP': instance.topP,
      'historyMessages': instance.historyMessages,
      'autoTitle': instance.autoTitle,
      'model': instance.model,
      'messages': instance.messages,
    };

RequestChatMessage _$RequestChatMessageFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['role'],
  );
  return RequestChatMessage(
    role: json['role'] as String,
    content: json['content'] as String,
  );
}

Map<String, dynamic> _$RequestChatMessageToJson(RequestChatMessage instance) =>
    <String, dynamic>{
      'role': instance.role,
      'content': instance.content,
    };
