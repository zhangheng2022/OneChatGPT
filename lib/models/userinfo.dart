import 'package:json_annotation/json_annotation.dart';
part 'userinfo.g.dart';

@JsonSerializable()
class Userinfo {
  String? uid;
  String? email;
  int? age;

  Userinfo({this.uid, this.email, this.age});

  // 从JSON创建User实例的工厂方法
  factory Userinfo.fromJson(Map<String, dynamic> json) =>
      _$UserinfoFromJson(json);

  // 将User实例转换为JSON的方法
  Map<String, dynamic> toJson() => _$UserinfoToJson(this);
}
