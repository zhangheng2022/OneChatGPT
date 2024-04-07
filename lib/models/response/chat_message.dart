import 'package:json_annotation/json_annotation.dart';
part 'chat_message.g.dart';

@JsonSerializable()
class ChatMessage {
  String text;

  ChatMessage({required this.text});

  // 从JSON创建User实例的工厂方法
  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  // 将User实例转换为JSON的方法
  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}
