import 'package:json_annotation/json_annotation.dart';

import 'question.dart';

part 'section.g.dart';

/// Section response model.
@JsonSerializable(nullable: false)
class Section {
  Section(this.id, this.name, this.ordinalNumber, this.questions);

  factory Section.fromJson(Map<String, dynamic> json) => _$SectionFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'ordinalNumber')
  final int ordinalNumber;

  @JsonKey(name: 'questions', nullable: true)
  final List<Question> questions;

  Section copyWith({
    String id,
    String name,
    int ordinalNumber,
    List<Question> questions
  }) {
    return Section(
      id ?? this.id,
      name ?? this.name,
      ordinalNumber ?? this.ordinalNumber,
      questions ?? this.questions
    );
  }

  Map<String, dynamic> toJson() => _$SectionToJson(this);
}
