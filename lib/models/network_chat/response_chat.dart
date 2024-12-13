import 'package:json_annotation/json_annotation.dart';
part 'response_chat.g.dart';

@JsonSerializable()
class ResponseChat {
  @JsonKey(required: true)
  String id;
  String? object;
  int created;
  String model;
  List<Choice> choices;

  ResponseChat({
    required this.id,
    this.object,
    required this.created,
    required this.model,
    required this.choices,
  });

  factory ResponseChat.fromJson(Map<String, dynamic> json) =>
      _$ResponseChatFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseChatToJson(this);
}

@JsonSerializable()
class Choice {
  int index;
  Delta delta;

  Choice({
    required this.index,
    required this.delta,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$ChoiceToJson(this);
}

@JsonSerializable()
class Delta {
  String? content;
  String? role;

  Delta({
    this.content,
    this.role,
  });

  factory Delta.fromJson(Map<String, dynamic> json) => _$DeltaFromJson(json);

  Map<String, dynamic> toJson() => _$DeltaToJson(this);
}
