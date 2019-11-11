import 'package:json_annotation/json_annotation.dart';

import 'question.dart';

part 'question_result.g.dart';

/// Question result model.
@JsonSerializable(nullable: false)
class QuestionResult {
  QuestionResult(this.answer, this.question);

  factory QuestionResult.fromJson(Map<String, dynamic> json) => _$QuestionResultFromJson(json);

  @JsonKey(name: 'answer')
  final String answer;

  @JsonKey(name: 'question')
  final Question question;

  Map<String, dynamic> toJson() => _$QuestionResultToJson(this);
}
