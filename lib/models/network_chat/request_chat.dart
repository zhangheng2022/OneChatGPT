import 'package:json_annotation/json_annotation.dart';
import 'package:one_chatgpt_flutter/models/model_setting/model_setting.dart';
part 'request_chat.g.dart';

@JsonSerializable()
class RequestChat extends ModelSetting {
  @JsonKey(required: true)
  String model;
  List<RequestChatMessage> messages;

  RequestChat({
    required this.messages,
    required this.model,
    super.maxTokens,
    super.temperature,
    super.topP,
    super.historyMessages,
    super.autoTitle,
  });

  factory RequestChat.fromJson(Map<String, dynamic> json) =>
      _$RequestChatFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RequestChatToJson(this);
}

@JsonSerializable()
class RequestChatMessage {
  @JsonKey(required: true)
  String role;
  String content;

  RequestChatMessage({
    required this.role,
    required this.content,
  });

  factory RequestChatMessage.fromJson(Map<String, dynamic> json) =>
      _$RequestChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$RequestChatMessageToJson(this);
}
