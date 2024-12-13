// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelSetting _$ModelSettingFromJson(Map<String, dynamic> json) => ModelSetting(
      maxTokens: (json['maxTokens'] as num?)?.toInt(),
      temperature: (json['temperature'] as num?)?.toDouble(),
      topP: (json['topP'] as num?)?.toDouble(),
      historyMessages: (json['historyMessages'] as num?)?.toDouble(),
      autoTitle: json['autoTitle'] as bool?,
    );

Map<String, dynamic> _$ModelSettingToJson(ModelSetting instance) =>
    <String, dynamic>{
      'maxTokens': instance.maxTokens,
      'temperature': instance.temperature,
      'topP': instance.topP,
      'historyMessages': instance.historyMessages,
      'autoTitle': instance.autoTitle,
    };
