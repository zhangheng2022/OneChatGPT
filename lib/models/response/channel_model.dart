import 'package:json_annotation/json_annotation.dart';
part 'channel_model.g.dart';

@JsonSerializable()
class ChannelModel {
  @JsonKey(required: true)
  int id;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  List<String> models;

  @JsonKey(name: 'provider_logo')
  String providerLogo;

  String provider;

  @JsonKey(name: 'portkey_config')
  dynamic portkeyConfig;

  bool host;

  ChannelModel({
    required this.id,
    required this.createdAt,
    required this.models,
    required this.providerLogo,
    required this.provider,
    required this.portkeyConfig,
    required this.host,
  });

  factory ChannelModel.fromJson(Map<String, dynamic> json) =>
      _$ChannelModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelModelToJson(this);
}
