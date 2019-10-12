import 'package:json_annotation/json_annotation.dart';

part 'conference_resource.g.dart';

/// Conference response model.
@JsonSerializable(nullable: false)
class ConferenceResource {
  ConferenceResource(this.id, this.title, this.description, this.pdfUrl);

  factory ConferenceResource.fromJson(Map<String, dynamic> json) => _$ConferenceResourceFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'pdf_url')
  final String pdfUrl;

  Map<String, dynamic> toJson() => _$ConferenceResourceToJson(this);
}
