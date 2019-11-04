import 'package:hosrem_app/api/article/article.dart';
import 'package:hosrem_app/api/article/article_pagination.dart';
import 'package:hosrem_app/api/auth/field.dart';
import 'package:hosrem_app/api/auth/field_pagination.dart';
import 'package:hosrem_app/network/api_provider.dart';

/// Article service.
class ArticleService {
  ArticleService(this.apiProvider) : assert(apiProvider != null);

  final ApiProvider apiProvider;

  /// Get articles.
  Future<ArticlePagination> getArticles(String categoryName, Map<String, dynamic> searchCriteria) async {
    // 1. If category is empty, we will search articles by search criteria.
    if (categoryName == null || categoryName.isEmpty) {
      return apiProvider.articleApi.getAll(searchCriteria);
    }

    // 2. Get category id from backend. If not found, the result will be empty.
    final FieldPagination fieldPagination = await apiProvider.articleApi.getAllCategories(<String, int>{
      'page': 0,
      'size': 1000
    });

    if (fieldPagination.items.isEmpty) {
      return ArticlePagination(0, 0, 0, 10, <Article>[]);
    }

    // 3. Query articles by category id.
    final Map<String, dynamic> queryParams = <String, dynamic>{
      'category': fieldPagination.items.firstWhere(
        (Field field) => field.name == categoryName,
        orElse: () => Field(_getCategoryIdByName(categoryName), categoryName, null)
      ).id
    };
    queryParams.addAll(searchCriteria);

    return apiProvider.articleApi.getAll(queryParams);
  }

  String _getCategoryIdByName(String categoryName) {
    final Map<String, String> maps = <String, String>{
      'Tin cộng đồng': '7f000001-6e2c-1e2f-816e-2c9f9660000a',
      'Tin trong nước': '0a000023-6e26-1b1f-816e-264bd6ef0001',
      'Tin quốc tế': '7f000001-6e2c-1e2f-816e-2c9f62d40001',
      'Sản khoa & nhi sơ sinh': '7f000001-6e2c-1e2f-816e-2c9fb5260010',
      'Phụ khoa': '7f000001-6e2e-1be2-816e-2e5fa4380011',
      'Mãn kinh': 'c0a89003-6db3-1fdb-816d-b395b3b80008',
      'Nam khoa': 'c0a89003-6db3-1fdb-816d-b3aba40e0011',
      'Vô sinh & hỗ trợ sinh sản': '7f000001-6e2c-1e2f-816e-2c9fa15d000d',
      'Khác': '7f000001-6e2e-1be2-816e-2e61063a0051'
    };

    return maps[categoryName] ?? '7f000001-6e2e-1be2-816e-2e61063a0051';
  }

  /// Get article by id.
  Future<Article> getArticle(String id) async {
    return apiProvider.articleApi.getArticleById(id);
  }
}
