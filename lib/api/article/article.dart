import 'package:hosrem_app/api/document/document.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

/// Conference response model.
@JsonSerializable(nullable: false)
class Article {
  Article(this.id, this.title, this.description, this.location, this.mode, this.startTime, this.banner,
    this.status, this.files, this.documents);

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'location')
  final String location;

  @JsonKey(name: 'mode')
  final String mode;

  @JsonKey(name: 'startTime')
  final DateTime startTime;

  @JsonKey(name: 'banner')
  final String banner;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'files', nullable: true)
  final List<String> files;

  @JsonKey(name: 'documents', nullable: true)
  final List<Document> documents;

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
