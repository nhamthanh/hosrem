import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

/// Category response model.
@JsonSerializable(nullable: false)
class Category {
  Category(this.id, this.name);

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
