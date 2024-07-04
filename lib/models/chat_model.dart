import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ChatModel {
  String model; // 模型 (model)
  int maxTokens; // 最大令牌数 (max_tokens)
  double temperature; // 随机性 (temperature)
  double topP; // 核采样 (top_p)
  int historyMessages; // 历史消息数 (history_messages)
  bool autoTitle; // 自动标题 (auto_title)

  ChatModel({
    required this.model,
    required this.maxTokens,
    required this.temperature,
    required this.topP,
    required this.historyMessages,
    required this.autoTitle,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}