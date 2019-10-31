import 'package:hosrem_app/api/article/article.dart';
import 'package:hosrem_app/api/article/article_pagination.dart';
import 'package:hosrem_app/network/api_provider.dart';

/// Article service.
class ArticleService {
  ArticleService(this.apiProvider) : assert(apiProvider != null);

  final ApiProvider apiProvider;

  /// Get articles.
  Future<ArticlePagination> getArticles(Map<String, dynamic> queryParams) async {
    final ArticlePagination articles = await apiProvider.articleApi.getAll(queryParams);
    return articles;
  }

  /// Get article by id.
  Future<Article> getArticle(String id) async {
    return apiProvider.articleApi.getArticleById(id);
  }
}
