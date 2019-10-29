import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'article.dart';
import 'article_pagination.dart';

part 'article_api.g.dart';

/// Article Api.
@RestApi()
abstract class ArticleApi {
  factory ArticleApi(Dio dio) = _ArticleApi;

  /// Get all articles.
  @GET('conferences')
  Future<ArticlePagination> getAll(@Queries() Map<String, dynamic> query);

  /// Get article by id.
  @GET('conferences/{id}')
  Future<Article> getArticleById(@Path() String id);
}

