import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/article/article.dart';
import 'package:hosrem_app/article/bloc/articles_bloc.dart';
import 'package:hosrem_app/article/bloc/articles_event.dart';
import 'package:hosrem_app/article/bloc/articles_state.dart';
import 'package:hosrem_app/article/container/category_featured_articles.dart';
import 'package:hosrem_app/article/widget/featured_article_item.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/loading/loading_indicator.dart';
import 'package:hosrem_app/widget/refresher/refresh_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../article_detail.dart';
import '../article_service.dart';
import '../category_articles.dart';

/// Public articles page.
class GroupArticles extends StatefulWidget {
  const GroupArticles({Key key, this.categories = const <String>[]}) : super(key: key);

  final List<String> categories;

  @override
  State<GroupArticles> createState() => _GroupArticlesState();
}

class _GroupArticlesState extends BaseState<GroupArticles> {
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
            _refreshController.refreshCompleted();
            _refreshController.loadComplete();

            if (state is LoadedArticlesState) {
              return _buildRefreshWidget(state);
            }

            if (state is ArticlesFailure) {
              return Center(
                child: Text(
                  AppLocalizations.of(context).tr('articles.no_article_found'),
                  style: TextStyles.textStyle16PrimaryBlack)
              );
            }

            return LoadingIndicator();
          }
        )
      )
    );
  }

  Widget _buildRefreshWidget(LoadedArticlesState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: RefreshWidget(
        child: ListView(
          children: <Widget>[
            _buildFeaturedSection(state.selectedArticle),
            const SizedBox(height: 15.0),
            Column(
              children: widget.categories.map((String categoryName) => Column(
                children: <Widget>[
                  const Divider(),
                  CategoryFeaturedArticles(categoryName, () => _navigateToCategoryArticles(categoryName),
                    criteria: const <String, dynamic>{
                      'size': 3
                    }
                  ),
                  const SizedBox(height: 15.0)
                ],
              )).toList(),
            )
          ]
        ),
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        refreshController: _refreshController
      )
    );
  }

  Widget _buildFeaturedSection(Article selectedArticle) {
    if (selectedArticle == null) {
      return Container();
    }

    return StickyHeader(
      header: Container(
        padding: const EdgeInsets.symmetric(vertical: 19.0, horizontal: 7.0),
        color: AppColors.backgroundConferenceColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    AppLocalizations.of(context).tr('articles.hot_news'),
                    style: TextStyles.textStyle22PrimaryBlack
                  )
                )
              ]
            )
          ]
        )
      ),
      content: Column(
        children: <Widget>[
          InkWell(
            child: FeaturedArticleItem(selectedArticle),
            onTap: () => _navigateToArticleDetail(selectedArticle)
          )
        ]
      )
    );
  }

  Future<void> _navigateToArticleDetail(Article article) async {
    await pushWidget(ArticleDetail(article.id, title: AppLocalizations.of(context).tr('articles.hot_news')));
  }

  void _onLoading() {
    _refreshController.loadComplete();
  }

  void _onRefresh() {
    _articlesBloc.dispatch(RefreshArticlesEvent(
      categoryName: widget.categories.isNotEmpty ? widget.categories[0] : '',
      searchCriteria: const <String, dynamic>{})
    );
  }

  Future<void> _navigateToCategoryArticles(String title) async {
    await pushWidget(CategoryArticles(title));
  }

  @override
  void dispose() {
    _articlesBloc.dispose();
    super.dispose();
  }
}
