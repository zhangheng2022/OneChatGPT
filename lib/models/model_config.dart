import 'package:json_annotation/json_annotation.dart';
part 'model_config.g.dart';

@JsonSerializable()
class ModelConfig {
  String model; // 模型名称
  int? maxTokens; // 最大令牌数 (max_tokens)
  double? temperature; // 随机性 (temperature)
  double? topP; // 核采样 (top_p)
  double? historyMessages; // 历史消息数 (history_messages)
  bool? autoTitle; // 自动标题 (auto_title)

  ModelConfig({
    required this.model,
    this.maxTokens,
    this.temperature,
    this.topP,
    this.historyMessages,
    this.autoTitle,
  });

  ModelConfig copyWith({
    String? model,
    int? maxTokens,
    double? temperature,
    double? topP,
    double? historyMessages,
    bool? autoTitle,
  }) {
    return ModelConfig(
      model: model ?? this.model,
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
