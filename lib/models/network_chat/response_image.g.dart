// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseImage _$ResponseImageFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['data'],
  );
  return ResponseImage(
    data: (json['data'] as List<dynamic>)
        .map((e) => ResponseImageData.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ResponseImageToJson(ResponseImage instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ResponseImageData _$ResponseImageDataFromJson(Map<String, dynamic> json) =>
    ResponseImageData(
      b64Json: json['b64_json'] as String,
    );

Map<String, dynamic> _$ResponseImageDataToJson(ResponseImageData instance) =>
    <String, dynamic>{
      'b64_json': instance.b64Json,
    };
