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
    configId: json['configId'] as String,
    logo: json['logo'] as String,
    company: json['company'] as String,
  );
}

Map<String, dynamic> _$ChannelModelToJson(ChannelModel instance) =>
    <String, dynamic>{
      'model': instance.model,
      'configId': instance.configId,
      'logo': instance.logo,
      'company': instance.company,
    };
