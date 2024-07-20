import 'package:json_annotation/json_annotation.dart';
part 'channel_model.g.dart';

@JsonSerializable()
class ChannelModel {
  @JsonKey(required: true)
  String model;
  String value;
  String label;
  String color;

  ChannelModel({
    required this.model,
    required this.value,
    required this.label,
    required this.color,
  });

  factory ChannelModel.fromJson(Map<String, dynamic> json) =>
      _$ChannelModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelModelToJson(this);
}
