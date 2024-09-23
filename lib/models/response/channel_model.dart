import 'package:json_annotation/json_annotation.dart';
part 'channel_model.g.dart';

@JsonSerializable()
class ChannelModel {
  @JsonKey(required: true)
  String model;
  String configId;
  String logo;
  String company;

  ChannelModel({
    required this.model,
    required this.configId,
    required this.logo,
    required this.company,
  });

  factory ChannelModel.fromJson(Map<String, dynamic> json) =>
      _$ChannelModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelModelToJson(this);
}
