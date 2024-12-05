// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelModel _$ChannelModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id'],
  );
  return ChannelModel(
    id: (json['id'] as num).toInt(),
    createdAt: DateTime.parse(json['created_at'] as String),
    models: (json['models'] as List<dynamic>).map((e) => e as String).toList(),
    providerLogo: json['provider_logo'] as String,
    provider: json['provider'] as String,
    portkeyConfig: json['portkey_config'],
    host: json['host'] as bool,
  );
}

Map<String, dynamic> _$ChannelModelToJson(ChannelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'models': instance.models,
      'provider_logo': instance.providerLogo,
      'provider': instance.provider,
      'portkey_config': instance.portkeyConfig,
      'host': instance.host,
    };
