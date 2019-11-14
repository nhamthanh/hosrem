import 'package:hosrem_app/api/article/article.dart';
import 'package:meta/meta.dart';

/// Articles state.
@immutable
abstract class ArticlesState {
}

/// ArticlesInitial state.
class ArticlesInitial extends ArticlesState {
  @override
  String toString() => 'ArticlesInitial';
}

/// ArticlesLoading state.
class ArticlesLoading extends ArticlesState {
  @override
  String toString() => 'ArticlesLoading';
}

/// ArticlesFailure state.
class ArticlesFailure extends ArticlesState {
  ArticlesFailure({@required this.error});

  final String error;

  @override
  String toString() => 'ArticlesFailure { error: $error }';
}

/// LoadedArticlesState state.
class LoadedArticlesState extends ArticlesState {
  LoadedArticlesState({@required this.articles, this.selectedArticle}) :
        assert(articles != null);

  final List<Article> articles;
  final Article selectedArticle;

  @override
  String toString() => 'LoadedArticlesState';
}

/// RefreshArticlesCompleted state.
@immutable
class RefreshArticlesCompleted extends ArticlesState {
  @override
  String toString() => 'RefreshArticlesCompleted';
}

/// LoadedArticlesState state.
class LoadedArticleState extends ArticlesState {
  LoadedArticleState({@required this.article, this.relativeArticles}) : assert(article != null);

  final Article article;

  final List<Article> relativeArticles;

  @override
  String toString() => 'LoadedArticleState';
}
