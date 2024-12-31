import 'package:json_annotation/json_annotation.dart';
part 'response_chat.g.dart';

@JsonSerializable()
class ResponseChat {
  @JsonKey(required: true)
  String id;
  String object;
  int created;
  String model;
  String? imageData;
  List<Choice> choices;

  ResponseChat({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    this.imageData,
    required this.choices,
  });

  factory ResponseChat.fromJson(Map<String, dynamic> json) =>
      _$ResponseChatFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseChatToJson(this);
}

@JsonSerializable()
class Choice {
  int index;
  @JsonKey(name: 'finish_reason')
  String? finishReason;
  MessageOrDelta? message;
  MessageOrDelta? delta;

  Choice({
    this.finishReason,
    required this.index,
    this.message,
    this.delta,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$ChoiceToJson(this);
}

@JsonSerializable()
class MessageOrDelta {
  String? content;
  String? role;

  MessageOrDelta({this.content, this.role});

  factory MessageOrDelta.fromJson(Map<String, dynamic> json) =>
      _$MessageOrDeltaFromJson(json);

  Map<String, dynamic> toJson() => _$MessageOrDeltaToJson(this);
}
