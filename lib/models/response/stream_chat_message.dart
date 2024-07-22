import 'package:json_annotation/json_annotation.dart';
part 'stream_chat_message.g.dart';

@JsonSerializable()
class StreamChatMessage {
  @JsonKey(required: true)
  String id;
  String? object;
  int created;
  String model;
  List<StreamChatMessageChoice> choices;

  StreamChatMessage({
    required this.id,
    this.object,
    required this.created,
    required this.model,
    required this.choices,
  });

  factory StreamChatMessage.fromJson(Map<String, dynamic> json) =>
      _$StreamChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$StreamChatMessageToJson(this);
}

@JsonSerializable()
class StreamChatMessageChoice {
  int index;
  StreamChatMessageDelta delta;

  StreamChatMessageChoice({
    required this.index,
    required this.delta,
  });

  factory StreamChatMessageChoice.fromJson(Map<String, dynamic> json) =>
      _$StreamChatMessageChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$StreamChatMessageChoiceToJson(this);
}

@JsonSerializable()
class StreamChatMessageDelta {
  String content;
  String? role;

  StreamChatMessageDelta({
    required this.content,
    this.role,
  });

  factory StreamChatMessageDelta.fromJson(Map<String, dynamic> json) =>
      _$StreamChatMessageDeltaFromJson(json);

  Map<String, dynamic> toJson() => _$StreamChatMessageDeltaToJson(this);
}
