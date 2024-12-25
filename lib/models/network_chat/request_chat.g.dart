// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestChat _$RequestChatFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['preset'],
  );
  return RequestChat(
    messages: (json['messages'] as List<dynamic>)
        .map((e) => RequestChatMessage.fromJson(e as Map<String, dynamic>))
        .toList(),
    preset: json['preset'] as String,
  );
}

Map<String, dynamic> _$RequestChatToJson(RequestChat instance) =>
    <String, dynamic>{
      'preset': instance.preset,
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
