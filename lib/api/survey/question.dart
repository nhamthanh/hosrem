import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

/// Question response model.
@JsonSerializable(nullable: false)
class Question {
  Question(this.id, this.title, this.ordinalNumber, this.answerType);

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'ordinalNumber')
  final int ordinalNumber;

  @JsonKey(name: 'answerType')
  final String answerType;

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
