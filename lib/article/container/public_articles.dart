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

import '../article_service.dart';
import '../category_articles.dart';

/// Public articles page.
class PublicArticles extends StatefulWidget {
  const PublicArticles({Key key, this.criteria = const <String, dynamic>{}}) : super(key: key);

  final Map<String, dynamic> criteria;

  @override
  State<PublicArticles> createState() => _PublicArticlesState();
}

class _PublicArticlesState extends BaseState<PublicArticles> {
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
              return _buildRefreshWidget(state.articles);
            }

            if (state is ArticlesFailure) {
              return Center(
                child: const Text('No article found')
              );
            }

            return LoadingIndicator();
          }
        )
      )
    );
  }

  Widget _buildRefreshWidget(List<Article> articles) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: RefreshWidget(
        child: ListView(
          children: <Widget>[
            _buildFeaturedSection(articles),
            const SizedBox(height: 15.0),
            const Divider(),
            CategoryFeaturedArticles('Tin cộng đồng', () => _navigateToCategoryArticles('Tin cộng đồng'),
              criteria: const <String, dynamic>{
                'status': 'Published',
                'sort': 'startTime:desc',
                'size': 3
              }
            ),
            const SizedBox(height: 15.0),
            const Divider(),
            CategoryFeaturedArticles('Tin trong nước', () => _navigateToCategoryArticles('Tin trong nước'),
              criteria: const<String, dynamic>{
                'status': 'Published',
                'sort': 'startTime:desc',
                'size': 3
              }
            ),
            const SizedBox(height: 15.0),
            const Divider(),
            CategoryFeaturedArticles('Tin quốc tế', () => _navigateToCategoryArticles('Tin quốc tế'),
              criteria: const <String, dynamic>{
                'status': 'Published',
                'sort': 'startTime:desc',
                'size': 3
              }
            ),
          ]
        ),
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        refreshController: _refreshController
      )
    );
  }

  Widget _buildFeaturedSection(List<Article> articles) {
    if (articles?.isEmpty ?? true) {
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
                    'Tin nổi bật',
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
          FeaturedArticleItem(articles[0])
        ]
      )
    );
  }

  void _onLoading() {
    _refreshController.loadComplete();
  }

  void _onRefresh() {
    _articlesBloc.dispatch(RefreshArticlesEvent(searchCriteria: widget.criteria));
  }

  void _navigateToCategoryArticles(String title) {
    Navigator.push(context, MaterialPageRoute<bool>(builder: (BuildContext context) => CategoryArticles(title)));
  }

  @override
  void dispose() {
    _articlesBloc.dispose();
    super.dispose();
  }
}
