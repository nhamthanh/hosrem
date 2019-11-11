import 'package:json_annotation/json_annotation.dart';

import 'question_result.dart';

part 'survey_result.g.dart';

/// Survey result model.
@JsonSerializable(nullable: false)
class SurveyResult {
  SurveyResult(this.answers, this.conferenceId, this.userId);

  factory SurveyResult.fromJson(Map<String, dynamic> json) => _$SurveyResultFromJson(json);

  @JsonKey(name: 'conferenceId')
  final String conferenceId;

  @JsonKey(name: 'userId')
  final String userId;

  @JsonKey(name: 'answers')
  final List<QuestionResult> answers;

  Map<String, dynamic> toJson() => _$SurveyResultToJson(this);
}
