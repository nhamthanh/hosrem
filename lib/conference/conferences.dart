import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/common/app_colors.dart';

import 'upcoming_conferences.dart';

/// Conferences page.
@immutable
class Conferences extends StatefulWidget {
  const Conferences({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ConferencesState createState() => _ConferencesState();
}

class _ConferencesState extends State<Conferences> with SingleTickerProviderStateMixin {

  List<Widget> tabs;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    tabs = <Widget>[
      Container(child: const Tab(text: 'Sắp Diễn Ra'), width: 120.0),
      Container(child: const Tab(text: 'Đã Hoàn Thành'), width: 120.0),
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
          labelStyle: const TextStyle(
            fontSize: 16.0
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16.0
          ),
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
            UpcomingConferences(criteria: <String, dynamic>{
              'status': 'RegisterOpen'
            }),
            UpcomingConferences(criteria: <String, dynamic>{
              'status': 'Done'
            }),
          ]
        )
      )
    );
  }
}
