// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelConfig _$ModelConfigFromJson(Map<String, dynamic> json) => ModelConfig(
      model: json['model'] as String,
      maxTokens: (json['maxTokens'] as num?)?.toInt(),
      temperature: (json['temperature'] as num?)?.toDouble(),
      topP: (json['topP'] as num?)?.toDouble(),
      historyMessages: (json['historyMessages'] as num?)?.toDouble(),
      autoTitle: json['autoTitle'] as bool?,
    );

Map<String, dynamic> _$ModelConfigToJson(ModelConfig instance) =>
    <String, dynamic>{
      'model': instance.model,
      'maxTokens': instance.maxTokens,
      'temperature': instance.temperature,
      'topP': instance.topP,
      'historyMessages': instance.historyMessages,
      'autoTitle': instance.autoTitle,
    };
