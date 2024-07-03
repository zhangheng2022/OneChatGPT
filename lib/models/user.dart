import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  late String id;
  late String aud;
  late String role;
  late String email;
  late String emailConfirmedAt;
  late String phone;
  late String lastSignInAt;
  late Map<String, dynamic> appMetadata;
  late Map<String, dynamic> userMetadata;
  late List<UserIdentity> identities;
  late String createdAt;
  late String updatedAt;

  User({
    required this.id,
    required this.aud,
    required this.role,
    required this.email,
    required this.emailConfirmedAt,
    required this.phone,
    required this.lastSignInAt,
    required this.appMetadata,
    required this.userMetadata,
    required this.identities,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserIdentity {
  late String identityId;
  late String id;
  late String userId;
  late Map<String, dynamic> identityData;
  late String provider;
  late String lastSignInAt;
  late String createdAt;
  late String updatedAt;

  UserIdentity({
    required this.identityId,
    required this.id,
    required this.userId,
    required this.identityData,
    required this.provider,
    required this.lastSignInAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserIdentity.fromJson(Map<String, dynamic> json) =>
      _$UserIdentityFromJson(json);

  Map<String, dynamic> toJson() => _$UserIdentityToJson(this);
}
