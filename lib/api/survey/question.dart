import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

/// Question response model.
@JsonSerializable(nullable: false)
class Question {
  Question(this.id, this.content, this.type);

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'title')
  final String content;

  @JsonKey(name: 'mode')
  final String type;

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
