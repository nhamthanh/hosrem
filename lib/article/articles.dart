import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/app/bloc/app_bloc.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/connection/connection_provider.dart';
import 'package:hosrem_app/notification/fcm_configuration.dart';

import 'container/group_articles.dart';

/// Articles page.
@immutable
class Articles extends StatefulWidget {
  const Articles({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ArticlesState createState() => _ArticlesState();
}

class _ArticlesState extends BaseState<Articles> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  @protected
  void onResumeWidget() {
    final FcmConfiguration fcmConfiguration = BlocProvider.of<AppBloc>(context).appContext.fcmConfiguration;
    fcmConfiguration.initFcm(context, requestToken: false, handleLaunchMsg: true);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          isScrollable: true,
          unselectedLabelColor: AppColors.unselectLabelColor,
          labelStyle: TextStyles.textStyle16,
          unselectedLabelStyle: TextStyles.textStyle16,
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BubbleTabIndicator(
            indicatorHeight: 36.0,
            indicatorColor: AppColors.lightPrimaryColor,
            indicatorRadius: 20.0,
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          tabs: <Widget>[
            Container(child: Tab(text: AppLocalizations.of(context).tr('articles.common_news')), width: 120.0),
            Container(child: Tab(text: AppLocalizations.of(context).tr('articles.major_news')), width: 139.0),
          ],
          controller: _tabController,
        ),
        backgroundColor: AppColors.backgroundConferenceColor,
        elevation: 0.0,
        centerTitle: true
      ),
      body: ConnectionProvider(
        child: Container(
          color: AppColors.backgroundConferenceColor,
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              GroupArticles(
                categories: const <String>[
                  'Tin quốc tế',
                  'Tin trong nước',
                  'Tin cộng đồng'
                ],
                onBackHandler: onResumeWidget
              ),
              GroupArticles(
                categories: const <String>[
                  'Sản khoa & nhi sơ sinh',
                  'Phụ khoa',
                  'Mãn kinh',
                  'Nam khoa',
                  'Vô sinh & hỗ trợ sinh sản',
                  'Khác'
                ],
                onBackHandler: onResumeWidget
              )
            ]
          )
        )
      )
    );
  }
}
