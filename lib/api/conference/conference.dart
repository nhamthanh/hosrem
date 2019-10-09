import 'package:json_annotation/json_annotation.dart';

part 'conference.g.dart';

/// Conference response model.
@JsonSerializable(nullable: false)
class Conference {
  Conference(this.id, this.title, this.description, this.photoUrl);

  factory Conference.fromJson(Map<String, dynamic> json) => _$ConferenceFromJson(json);

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'photo_url')
  final String photoUrl;

  Map<String, dynamic> toJson() => _$ConferenceToJson(this);
}
