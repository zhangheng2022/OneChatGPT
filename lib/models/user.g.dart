// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      aud: json['aud'] as String,
      role: json['role'] as String,
      email: json['email'] as String,
      emailConfirmedAt: json['emailConfirmedAt'] as String,
      phone: json['phone'] as String,
      lastSignInAt: json['lastSignInAt'] as String,
      appMetadata: json['appMetadata'] as Map<String, dynamic>,
      userMetadata: json['userMetadata'] as Map<String, dynamic>,
      identities: (json['identities'] as List<dynamic>)
          .map((e) => UserIdentity.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'aud': instance.aud,
      'role': instance.role,
      'email': instance.email,
      'emailConfirmedAt': instance.emailConfirmedAt,
      'phone': instance.phone,
      'lastSignInAt': instance.lastSignInAt,
      'appMetadata': instance.appMetadata,
      'userMetadata': instance.userMetadata,
      'identities': instance.identities,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

UserIdentity _$UserIdentityFromJson(Map<String, dynamic> json) => UserIdentity(
      identityId: json['identityId'] as String,
      id: json['id'] as String,
      userId: json['userId'] as String,
      identityData: json['identityData'] as Map<String, dynamic>,
      provider: json['provider'] as String,
      lastSignInAt: json['lastSignInAt'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$UserIdentityToJson(UserIdentity instance) =>
    <String, dynamic>{
      'identityId': instance.identityId,
      'id': instance.id,
      'userId': instance.userId,
      'identityData': instance.identityData,
      'provider': instance.provider,
      'lastSignInAt': instance.lastSignInAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
