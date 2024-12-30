import 'package:json_annotation/json_annotation.dart';
part 'response_image.g.dart';

@JsonSerializable()
class ResponseImage {
  @JsonKey(required: true)
  List<ResponseImageData> data;

  ResponseImage({
    required this.data,
  });

  factory ResponseImage.fromJson(Map<String, dynamic> json) =>
      _$ResponseImageFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseImageToJson(this);
}

@JsonSerializable()
class ResponseImageData {
  String url;

  ResponseImageData({
    required this.url,
  });

  factory ResponseImageData.fromJson(Map<String, dynamic> json) =>
      _$ResponseImageDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseImageDataToJson(this);
}
