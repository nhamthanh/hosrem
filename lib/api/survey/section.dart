import 'package:json_annotation/json_annotation.dart';

import 'question.dart';

part 'section.g.dart';

/// Section response model.
@JsonSerializable(nullable: false)
class Section {
  Section(this.id, this.name, this.description, this.questions);

  factory Section.fromJson(Map<String, dynamic> json) => _$SectionFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'milestone')
  final String name;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'questions', nullable: true)
  final List<Question> questions;

  Section copyWith({
    String id,
    String name,
    String description,
    List<Question> questions
  }) {
    return Section(
      id ?? this.id,
      name ?? this.name,
      description ?? this.description,
      questions ?? this.questions
    );
  }

  Map<String, dynamic> toJson() => _$SectionToJson(this);
}
