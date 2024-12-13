import 'package:json_annotation/json_annotation.dart';
part 'network_channel.g.dart';

@JsonSerializable()
class NetworkChannel {
  List<String> models;

  @JsonKey(name: 'provider_logo')
  String providerLogo;

  String provider;

  @JsonKey(name: 'portkey_config')
  dynamic portkeyConfig;

  bool host;

  NetworkChannel({
    required this.models,
    required this.providerLogo,
    required this.provider,
    required this.portkeyConfig,
    required this.host,
  });

  factory NetworkChannel.fromJson(Map<String, dynamic> json) =>
      _$NetworkChannelFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkChannelToJson(this);
}
