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
  LoadedArticlesState({@required this.articles}) : assert(articles != null);

  final List<Article> articles;

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
  LoadedArticleState({@required this.article}) : assert(article != null);

  final Article article;

  @override
  String toString() => 'LoadedArticleState';
}
