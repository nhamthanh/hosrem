import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/article/article.dart';
import 'package:hosrem_app/article/bloc/articles_bloc.dart';
import 'package:hosrem_app/article/bloc/articles_event.dart';
import 'package:hosrem_app/article/bloc/articles_state.dart';
import 'package:hosrem_app/article/widget/article_category_header.dart';
import 'package:hosrem_app/article/widget/article_item.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/loading/loading_indicator.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../article_detail.dart';
import '../article_service.dart';


/// Category featured articles widget.
class CategoryFeaturedArticles extends StatefulWidget {
  const CategoryFeaturedArticles(this.categoryName, this.onTapSeeAll,
    { Key key, this.criteria = const <String, dynamic>{}}) : super(key: key);

  final String categoryName;
  final Function() onTapSeeAll;
  final Map<String, dynamic> criteria;

  @override
  State<CategoryFeaturedArticles> createState() => _CategoryFeaturedArticlesState();
}

class _CategoryFeaturedArticlesState extends BaseState<CategoryFeaturedArticles> {
  ArticlesBloc _articlesBloc;

  @override
  void initState() {
    super.initState();
    _articlesBloc = ArticlesBloc(articleService: ArticleService(apiProvider));
    _articlesBloc.dispatch(RefreshArticlesEvent(categoryName: widget.categoryName, searchCriteria: widget.criteria));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ArticlesBloc>(
      builder: (BuildContext context) => _articlesBloc,
      child: BlocListener<ArticlesBloc, ArticlesState>(
        listener: (BuildContext context, ArticlesState state) {
        },
        child: BlocBuilder<ArticlesBloc, ArticlesState>(
          bloc: _articlesBloc,
          builder: (BuildContext context, ArticlesState state) {
            if (state is LoadedArticlesState) {
              return _buildRefreshWidget(state.articles);
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

  Widget _buildRefreshWidget(List<Article> articles) {
    return StickyHeader(
      header: ArticleCategoryHeader(title: widget.categoryName, onTapSeeAll: widget.onTapSeeAll),
      content: articles.isNotEmpty ? Container(
        child: Column(
          children: articles.map((Article article) => InkWell(
            child: ArticleItem(article),
            onTap: () => _navigateToArticleDetail(article),
          )).toList()
        )
      ) : Container()
    );
  }

  void _navigateToArticleDetail(Article article) {
    Navigator.push(
      context,
      MaterialPageRoute<bool>(
        builder: (BuildContext context) => ArticleDetail(article.id, title: widget.categoryName)
      )
    );
  }

  @override
  void dispose() {
    _articlesBloc.dispose();
    super.dispose();
  }
}
