import 'package:json_annotation/json_annotation.dart';

part 'degree.g.dart';

/// Field response model.
@JsonSerializable(nullable: false)
class Degree {
  Degree(this.id, this.name);

  factory Degree.fromJson(Map<String, dynamic> json) => _$DegreeFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  Map<String, dynamic> toJson() => _$DegreeToJson(this);
}
