import 'package:json_annotation/json_annotation.dart';

import 'section.dart';

part 'survey.g.dart';

/// Section response model.
@JsonSerializable(nullable: false)
class Survey {
  Survey(this.id, this.sections);

  factory Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'memberFees', nullable: true)
  final List<Section> sections;

  Map<String, dynamic> toJson() => _$SurveyToJson(this);
}
