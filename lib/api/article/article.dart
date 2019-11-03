import 'package:json_annotation/json_annotation.dart';

import 'category.dart';

part 'article.g.dart';

/// Article response model.
@JsonSerializable(nullable: false)
class Article {
  Article(this.id, this.avatar, this.author, this.content, this.category, this.title, this.source, this.publishTime, this.status);

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'avatar')
  final String avatar;

  @JsonKey(name: 'author')
  final String author;

  @JsonKey(name: 'content')
  final String content;

  @JsonKey(name: 'category', nullable: true)
  final Category category;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'source')
  final String source;

  @JsonKey(name: 'publishTime')
  final DateTime publishTime;

  @JsonKey(name: 'status')
  final String status;

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
