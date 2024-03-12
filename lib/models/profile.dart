import 'package:json_annotation/json_annotation.dart';
import 'user.dart';
part 'profile.g.dart';

@JsonSerializable(explicitToJson: true)
class Profile {
  Profile(this.user, this.theme);

  final int? theme;
  final User? user;

  // 从JSON创建User实例的工厂方法
  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  // 将User实例转换为JSON的方法
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
