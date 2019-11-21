import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hosrem_app/article/bloc/articles_bloc.dart';
import 'package:hosrem_app/article/bloc/articles_state.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/date_time_utils.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/connection/connection_provider.dart';
import 'package:hosrem_app/widget/svg/svg_icon.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hosrem_app/api/article/article.dart';

import 'article_service.dart';
import 'bloc/articles_event.dart';

/// Article details page.
class ArticleDetail extends StatefulWidget {
  const ArticleDetail(this.id, { Key key, this.title = '' }) : super(key: key);

  final String id;
  final String title;

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends BaseState<ArticleDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ArticlesBloc _articlesBloc;

  @override
  void initState() {
    super.initState();
    _articlesBloc = ArticlesBloc(articleService: ArticleService(apiProvider));
    _articlesBloc.dispatch(LoadArticleEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ArticlesBloc>(
      builder: (BuildContext context) => _articlesBloc,
      child: BlocListener<ArticlesBloc, ArticlesState>(
        listener: (BuildContext context, ArticlesState state) {
          if (state is ArticlesFailure) {
            _scaffoldKey.currentState.showSnackBar(
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
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text(widget.title),
                centerTitle: true
              ),
              body: ConnectionProvider(
                child: LoadingOverlay(
                  child: _buildPageContent(state),
                  isLoading: state is ArticlesLoading
                )
              )
            );
          }
        )
      )
    );
  }

  Widget _buildPageContent(ArticlesState state) {
    if (state is LoadedArticleState) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 35.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                state.article.title,
                style: TextStyles.textStyle24PrimaryBlack
              ),
              const SizedBox(height: 13.0),
              Row(
                children: <Widget>[
                  Container(
                    child: SvgIcon(AppAssets.calendarIcon, size: 20.0, color: AppColors.secondaryGreyColor)
                  ),
                  const SizedBox(width: 12.0),
                  Text(
                    DateTimeUtils.format(state.article.publishTime.toLocal()),
                    style: TextStyles.textStyle14PrimaryRed
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              Container(
                height: 168.0,
                child: CachedNetworkImage(
                  imageUrl: state.article.avatar ?? 'https://',
                  imageBuilder: (BuildContext context, ImageProvider imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color.fromRGBO(52, 169, 255, 0.1),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain
                      ),
                    )
                  ),
                  placeholder: (BuildContext context, String url) => Center(child: const CircularProgressIndicator()),
                  errorWidget: (BuildContext context, String url, Object error) =>
                    Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                      Container(
                        height: 168.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color.fromRGBO(52, 169, 255, 0.1)
                        ),
                        child: Image.asset(AppAssets.articlePlaceholder)
                      )
                    ])),
              ),
              const SizedBox(height: 24.0),
              Html(
                data: state.article.content,
                useRichText: false,
                padding: const EdgeInsets.all(8.0),
                onLinkTap: (String url) async {
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                }
              ),
              const SizedBox(height: 16.0),
              state.relativeArticles.isNotEmpty ? Row(
                children: <Widget>[
                  Expanded(
                    child: Text (
                      AppLocalizations.of(context).tr('articles.related_news'),
                      style: TextStyles.textStyle22PrimaryBlackBold,
                    ),
                  )
                ],
              ) : Container(),
              const SizedBox(height: 16.0),
              state.relativeArticles.isNotEmpty ? Column(
                children: state.relativeArticles.map((Article article) =>
                  Column(children: <Widget>[
                    InkWell(
                        child: Row(children: <Widget>[
                          Expanded(
                            child: Text(
                              article.title,
                              maxLines: 2,
                              style: TextStyles.textStyle16PrimaryBlue,
                              overflow: TextOverflow.ellipsis,
                            )
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: AppColors.primaryBlackColor,
                              size: 18.0
                            ),
                            onPressed: () {},
                          ),
                        ]),
                        onTap: () => _navigateToArticleDetail(article)
                      ),
                      const SizedBox(height: 15.0),
                  ],)
                ).toList(),
              ) : Container(),
            ],
          )
        )
      );
    }

    return Container();
  }

  @override
  void dispose() {
    _articlesBloc.dispose();
    super.dispose();
  }

  void _navigateToArticleDetail(Article article) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<bool>(
        builder: (BuildContext context) => ArticleDetail(article.id,
          title: AppLocalizations.of(context).tr(article.category.name)
        )
      )
    );
  }

}
