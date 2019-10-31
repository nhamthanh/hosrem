import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/text_styles.dart';

import 'package:hosrem_app/article/container/public_articles.dart';

/// Articles page.
@immutable
class Articles extends StatefulWidget {
  const Articles({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ArticlesState createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> with SingleTickerProviderStateMixin {

  List<Widget> tabs;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    tabs = <Widget>[
      Container(child: const Tab(text: 'Tin Cộng Đồng'), width: 120.0),
      Container(child: const Tab(text: 'Tin Chuyên Ngành'), width: 120.0),
    ];
    _tabController = TabController(vsync: this, length: tabs.length);
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
          tabs: tabs,
          controller: _tabController,
        ),
        backgroundColor: AppColors.backgroundConferenceColor,
        elevation: 0.0,
        centerTitle: true
      ),
      body: Container(
        color: AppColors.backgroundConferenceColor,
        child: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            PublicArticles(criteria: <String, dynamic>{
              'status': 'Published',
              'sort': 'startTime:asc',
              'size': 1
            }),
            PublicArticles(criteria: <String, dynamic>{
              'status': 'Done',
              'sort': 'startTime:desc',
              'size': 1
            }),
          ]
        )
      )
    );
  }
}
