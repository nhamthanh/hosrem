import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/common/app_colors.dart';

/// Conferences page.
@immutable
class Conferences extends StatefulWidget {
  const Conferences({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ConferencesState createState() => _ConferencesState();
}

class _ConferencesState extends State<Conferences> with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(text: 'Upcoming'),
    Tab(text: 'Completed')];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar(
          isScrollable: true,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BubbleTabIndicator(
            indicatorHeight: 25.0,
            indicatorColor: AppColors.lightPrimaryColor,
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          tabs: tabs,
          controller: _tabController,
        ),
        Expanded(
            child: TabBarView(
          controller: _tabController,
          children: tabs.map((Tab tab) {
            return Center(
              child: Text(
                tab.text,
                style: TextStyle(fontSize: 20.0)
              )
            );
          }).toList(),
        ))
      ],
    );
  }
}
