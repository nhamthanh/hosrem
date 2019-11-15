import 'package:dio/dio.dart';
import 'package:hosrem_app/api/auth/field_pagination.dart';
import 'package:retrofit/retrofit.dart';

import 'article.dart';
import 'article_pagination.dart';

part 'article_api.g.dart';

/// Article Api.
@RestApi()
abstract class ArticleApi {
  factory ArticleApi(Dio dio) = _ArticleApi;

  /// Get all articles.
  @GET('news')
  Future<ArticlePagination> getAll(@Queries() Map<String, dynamic> query);

  /// Get article by id.
  @GET('news/{id}')
  Future<Article> getArticleById(@Path() String id);

  /// Get all news categories.
  @GET('news/categories')
  Future<FieldPagination> getAllCategories(@Queries() Map<String, dynamic> query);

  /// Get all news by category.
  @GET('news')
  Future<ArticlePagination> getNewsByCategories(@Queries() Map<String, dynamic> query);
}

