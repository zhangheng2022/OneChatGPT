import 'package:json_annotation/json_annotation.dart';
part 'model_config.g.dart';

@JsonSerializable()
class ModelConfig {
  int maxTokens; // 最大令牌数 (max_tokens)
  double temperature; // 随机性 (temperature)
  double topP; // 核采样 (top_p)
  int historyMessages; // 历史消息数 (history_messages)
  bool autoTitle; // 自动标题 (auto_title)

  ModelConfig({
    required this.maxTokens,
    required this.temperature,
    required this.topP,
    required this.historyMessages,
    required this.autoTitle,
  });

  ModelConfig copyWith({
    int? maxTokens,
    double? temperature,
    double? topP,
    int? historyMessages,
    bool? autoTitle,
  }) {
    return ModelConfig(
      maxTokens: maxTokens ?? this.maxTokens,
      temperature: temperature ?? this.temperature,
      topP: topP ?? this.topP,
      historyMessages: historyMessages ?? this.historyMessages,
      autoTitle: autoTitle ?? this.autoTitle,
    );
  }

  factory ModelConfig.fromJson(Map<String, dynamic> json) =>
      _$ModelConfigFromJson(json);

  Map<String, dynamic> toJson() => _$ModelConfigToJson(this);
}
