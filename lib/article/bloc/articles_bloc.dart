import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/article/article.dart';
import 'package:hosrem_app/api/article/article_pagination.dart';
import 'package:hosrem_app/common/error_handler.dart';

import '../article_service.dart';
import 'articles_event.dart';
import 'articles_state.dart';

/// Article bloc to load articles.
class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  ArticlesBloc({@required this.articleService}) : assert(articleService != null);

  static const int DEFAULT_PAGE = 0;
  static const int DEFAULT_PAGE_SIZE = 10;

  final ArticleService articleService;

  List<Article> _articles = <Article>[];
  ArticlePagination _articlePagination;

  @override
  ArticlesState get initialState => ArticlesInitial();

  @override
  Stream<ArticlesState> mapEventToState(ArticlesEvent event) async* {
    if (event is RefreshArticlesEvent) {
      try {
        final Map<String, dynamic> queryParams = <String, dynamic>{
          'page': DEFAULT_PAGE,
          'size': DEFAULT_PAGE_SIZE,
          'sort': 'publishTime:desc'
        };
        queryParams.addAll(event.searchCriteria);

        _articlePagination = await articleService.getArticles(event.categoryName, queryParams);
        _articles = _articlePagination.items;

        yield RefreshArticlesCompleted();
        yield LoadedArticlesState(
          articles: _articles,
          selectedArticle: _articles.isEmpty ? null : _articles[Random().nextInt(_articles.length)]
        );
      } catch (error) {
        print(error);
        yield ArticlesFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is LoadMoreArticlesEvent) {
      try {
        if (_articlePagination.page < _articlePagination.totalPages) {
          final Map<String, dynamic> queryParams = <String, dynamic>{
            'page': _articlePagination.page + 1,
            'size': DEFAULT_PAGE_SIZE,
            'sort': 'publishTime:desc'
          };
          queryParams.addAll(event.searchCriteria);

          _articlePagination = await articleService.getArticles(event.categoryName, queryParams);
          _articles.addAll(_articlePagination.items);
        }
        yield LoadedArticlesState(articles: _articles);
      } catch (error) {
        print(error);
        yield ArticlesFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is LoadArticleEvent) {
      try {
        yield ArticlesLoading();
        yield LoadedArticleState(article: await articleService.getArticle(event.id));
      } catch (error) {
        print(error);
        yield ArticlesFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }
}
