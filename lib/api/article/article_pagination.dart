import 'package:json_annotation/json_annotation.dart';

import 'package:hosrem_app/api/pagination/pagination.dart';

import 'article.dart';

part 'article_pagination.g.dart';

/// Article response model.
@JsonSerializable(nullable: false)
class ArticlePagination extends Pagination<Article> {
  ArticlePagination(int totalItems, int page, int totalPages, int size, List<Article> items)
    : super(totalItems, page, totalPages, size, items);

  factory ArticlePagination.fromJson(Map<String, dynamic> json) => _$ArticlePaginationFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlePaginationToJson(this);
}
