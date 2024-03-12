import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  String? uid;
  String? email;

  User({required this.uid, required this.email});

  // 从JSON创建User实例的工厂方法
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // 将User实例转换为JSON的方法
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
