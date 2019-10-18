import 'package:json_annotation/json_annotation.dart';

part 'field.g.dart';

/// Field response model.
@JsonSerializable(nullable: false)
class Field {
  Field(this.id, this.name, this.description);

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'description')
  final String description;

  Map<String, dynamic> toJson() => _$FieldToJson(this);
}
