// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkChannel _$NetworkChannelFromJson(Map<String, dynamic> json) =>
    NetworkChannel(
      models:
          (json['models'] as List<dynamic>).map((e) => e as String).toList(),
      providerLogo: json['provider_logo'] as String,
      provider: json['provider'] as String,
      portkeyConfig: json['portkey_config'],
      host: json['host'] as bool,
    );

Map<String, dynamic> _$NetworkChannelToJson(NetworkChannel instance) =>
    <String, dynamic>{
      'models': instance.models,
      'provider_logo': instance.providerLogo,
      'provider': instance.provider,
      'portkey_config': instance.portkeyConfig,
      'host': instance.host,
    };
