// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      json['userinfo'] == null
          ? null
          : Userinfo.fromJson(json['userinfo'] as Map<String, dynamic>),
      json['theme'] as int?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'theme': instance.theme,
      'userinfo': instance.userinfo?.toJson(),
    };
