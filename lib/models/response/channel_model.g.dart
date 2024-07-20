// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelModel _$ChannelModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['model'],
  );
  return ChannelModel(
    model: json['model'] as String,
    value: json['value'] as String,
    label: json['label'] as String,
    color: json['color'] as String,
  );
}

Map<String, dynamic> _$ChannelModelToJson(ChannelModel instance) =>
    <String, dynamic>{
      'model': instance.model,
      'value': instance.value,
      'label': instance.label,
      'color': instance.color,
    };
