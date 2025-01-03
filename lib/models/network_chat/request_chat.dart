import 'package:json_annotation/json_annotation.dart';
part 'request_chat.g.dart';

@JsonSerializable()
class RequestChat {
  @JsonKey(required: true)
  String preset;
  List<RequestChatMessage> messages;

  RequestChat({
    required this.messages,
    required this.preset,
  });

  factory RequestChat.fromJson(Map<String, dynamic> json) =>
      _$RequestChatFromJson(json);

  Map<String, dynamic> toJson() => _$RequestChatToJson(this);
}

@JsonSerializable()
class RequestChatMessage {
  @JsonKey(required: true)
  String role;
  dynamic content;

  RequestChatMessage({
    required this.role,
    required this.content,
  });

  factory RequestChatMessage.fromJson(Map<String, dynamic> json) =>
      _$RequestChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$RequestChatMessageToJson(this);
}
