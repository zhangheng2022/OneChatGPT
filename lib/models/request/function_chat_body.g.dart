// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'function_chat_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FunctionChatBody _$FunctionChatBodyFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['messages'],
  );
  return FunctionChatBody(
    messages: (json['messages'] as List<dynamic>)
        .map((e) => FunctionChatBodyMessage.fromJson(e as Map<String, dynamic>))
        .toList(),
    model: json['model'] as String,
    maxTokens: (json['maxTokens'] as num?)?.toInt(),
    temperature: (json['temperature'] as num?)?.toDouble(),
    topP: (json['topP'] as num?)?.toDouble(),
    historyMessages: (json['historyMessages'] as num?)?.toDouble(),
    autoTitle: json['autoTitle'] as bool?,
  );
}

Map<String, dynamic> _$FunctionChatBodyToJson(FunctionChatBody instance) =>
    <String, dynamic>{
      'model': instance.model,
      'maxTokens': instance.maxTokens,
      'temperature': instance.temperature,
      'topP': instance.topP,
      'historyMessages': instance.historyMessages,
      'autoTitle': instance.autoTitle,
      'messages': instance.messages,
    };

FunctionChatBodyMessage _$FunctionChatBodyMessageFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['role'],
  );
  return FunctionChatBodyMessage(
    role: json['role'] as String,
    content: json['content'] as String,
  );
}

Map<String, dynamic> _$FunctionChatBodyMessageToJson(
        FunctionChatBodyMessage instance) =>
    <String, dynamic>{
      'role': instance.role,
      'content': instance.content,
    };
