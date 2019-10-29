import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:hosrem_app/widget/svg/svg_icon.dart';
import 'package:loading_overlay/loading_overlay.dart';

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
              body: LoadingOverlay(
                child: _buildPageContent(state),
                isLoading: state is ArticlesLoading
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
                'Sự phân mảnh dna tinh trùng và thụ tinh ống phân mảnh dna',
                style: TextStyles.textStyle24PrimaryBlack
              ),
              const SizedBox(height: 13.0),
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: SvgIcon(AppAssets.calendarIcon, size: 20.0, color: AppColors.secondaryGreyColor)
                  ),
                  const SizedBox(width: 12.0),
                  Text(
                    DateTimeUtils.format(DateTime.now()),
                    style: TextStyles.textStyle14PrimaryRed
                  ),
                ],
              ),
              const SizedBox(height: 13.0),
              Container(
                padding: const EdgeInsets.all(28.0),
                child: CachedNetworkImage(
                  imageUrl: 'https://',
                  placeholder: (BuildContext context, String url) => Center(child: const CircularProgressIndicator()),
                  errorWidget: (BuildContext context, String url, Object error) =>
                    Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                      Container(
                        height: 168.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color.fromRGBO(52, 169, 255, 0.1)
                        ),
                        child: Image.asset(AppAssets.articlePlaceholder))
                    ])),
              ),
              const SizedBox(height: 13.0),
              Html(
                data: """
                    <div>Follow<a class='sup'><sup>pl</sup></a> 
                      Below hr
                        <b>Bold</b>
                    <h1>what was sent down to you from your Lord</h1>, 
                    and do not follow other guardians apart from Him. Little do 
                    <span class='h'>you remind yourselves</span><a class='f'><sup f=2437>1</sup></a></div>
                    """,
                padding: EdgeInsets.all(8.0),
              ),
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
}
