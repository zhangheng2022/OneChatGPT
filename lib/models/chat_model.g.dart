// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      fullName: json['fullName'] as String,
      source: json['source'] as String,
      model: json['model'] as String,
      maxTokens: (json['maxTokens'] as num).toInt(),
      temperature: (json['temperature'] as num).toDouble(),
      topP: (json['topP'] as num).toDouble(),
      historyMessages: (json['historyMessages'] as num).toInt(),
      autoTitle: json['autoTitle'] as bool,
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'fullName': instance.fullName,
      'source': instance.source,
      'model': instance.model,
      'maxTokens': instance.maxTokens,
      'temperature': instance.temperature,
      'topP': instance.topP,
      'historyMessages': instance.historyMessages,
      'autoTitle': instance.autoTitle,
    };
