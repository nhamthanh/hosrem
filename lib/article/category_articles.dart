import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/article/article.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/loading/loading_indicator.dart';
import 'package:hosrem_app/widget/refresher/refresh_widget.dart';
import 'package:hosrem_app/widget/text/search_text_field.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:hosrem_app/article/widget/article_item.dart';
import 'article_service.dart';
import 'bloc/articles_bloc.dart';
import 'bloc/articles_event.dart';
import 'bloc/articles_state.dart';

/// Articles of category page.
class CategoryArticles extends StatefulWidget {
  const CategoryArticles(this.title, { Key key, this.criteria = const <String, dynamic>{} }) : super(key: key);

  final String title;
  final Map<String, dynamic> criteria;

  @override
  State<CategoryArticles> createState() => _CategoryArticlesState();
}

class _CategoryArticlesState extends BaseState<CategoryArticles> {
  RefreshController _refreshController;
  ArticlesBloc _articlesBloc;

  @override
  void initState() {
    super.initState();
    _articlesBloc = ArticlesBloc(articleService: ArticleService(apiProvider));
    _refreshController = RefreshController();

    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ArticlesBloc>(
      builder: (BuildContext context) => _articlesBloc,
      child: BlocListener<ArticlesBloc, ArticlesState>(
        listener: (BuildContext context, ArticlesState state) {
          if (state is ArticlesFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<ArticlesBloc, ArticlesState>(
          bloc: _articlesBloc,
          builder: (BuildContext context, ArticlesState state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
                centerTitle: true
              ),
              body: _buildPageContent(state)
            );

          }
        )
      )
    );
  }

  Widget _buildPageContent(ArticlesState state) {
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();

    if (state is LoadedArticlesState) {
      return _buildRefreshWidget(state.articles);
    }

    if (state is ArticlesFailure) {
      return Center(
        child: const Text('No news found')
      );
    }

    return LoadingIndicator();
  }

  Widget _buildRefreshWidget(List<Article> articles) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SearchTextField(
                    executeSearch: _searchConferences
                  )
                ),
              ],
            )
          ),
          Expanded(
            child: RefreshWidget(
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (BuildContext context, int index) {
                  final Article article = articles[index];
                  return InkWell(
                    child: ArticleItem(article),
                    onTap: () {
                    }
                  );
                },
              ),
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              refreshController: _refreshController
            )
          )
        ],
      )
    );
  }

  void _onLoading() {
    _articlesBloc.dispatch(LoadMoreArticlesEvent(searchCriteria: widget.criteria));
  }

  void _onRefresh() {
    _articlesBloc.dispatch(RefreshArticlesEvent(searchCriteria: widget.criteria));
  }

  void _searchConferences(String value) {
  }

  @override
  void dispose() {
    _articlesBloc.dispose();
    super.dispose();
  }
}
