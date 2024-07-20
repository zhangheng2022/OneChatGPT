import 'package:json_annotation/json_annotation.dart';
import 'package:one_chatgpt_flutter/models/model_config.dart';
part 'function_chat_body.g.dart';

@JsonSerializable()
class FunctionChatBody extends ModelConfig {
  @JsonKey(required: true)
  String model;
  List<FunctionChatBodyMessage> messages;

  FunctionChatBody({
    required this.messages,
    required this.model,
    super.maxTokens,
    super.temperature,
    super.topP,
    super.historyMessages,
    super.autoTitle,
  });

  factory FunctionChatBody.fromJson(Map<String, dynamic> json) =>
      _$FunctionChatBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FunctionChatBodyToJson(this);
}

@JsonSerializable()
class FunctionChatBodyMessage {
  @JsonKey(required: true)
  String role;
  String content;

  FunctionChatBodyMessage({
    required this.role,
    required this.content,
  });

  factory FunctionChatBodyMessage.fromJson(Map<String, dynamic> json) =>
      _$FunctionChatBodyMessageFromJson(json);

  Map<String, dynamic> toJson() => _$FunctionChatBodyMessageToJson(this);
}
