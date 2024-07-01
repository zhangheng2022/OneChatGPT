import 'package:json_annotation/json_annotation.dart';
part 'chat_message.g.dart';

@JsonSerializable()
class ChatMessage {
  @JsonKey(required: true)
  String id;
  String object;
  int created;
  String model;
  List<ChatMessageChoice> choices;

  ChatMessage({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}

@JsonSerializable()
class ChatMessageChoice {
  int index;
  ChatMessageDelta delta;

  ChatMessageChoice({
    required this.index,
    required this.delta,
  });

  factory ChatMessageChoice.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageChoiceToJson(this);
}

@JsonSerializable()
class ChatMessageDelta {
  String content;

  ChatMessageDelta({
    required this.content,
  });

  factory ChatMessageDelta.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageDeltaFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageDeltaToJson(this);
}
