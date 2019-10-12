import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/config/api_config.dart';
import 'package:hosrem_app/pdf/pdf_viewer.dart';

import 'conference_overview.dart';
import 'conference_resources.dart';

/// Conference detail page.
@immutable
class ConferenceDetail extends StatefulWidget {
  const ConferenceDetail(this.conference, this.apiConfig, this.token);

  final Conference conference;
  final String token;
  final ApiConfig apiConfig;

  @override
  _ConferenceDetailState createState() => _ConferenceDetailState();
}

class _ConferenceDetailState extends State<ConferenceDetail> with SingleTickerProviderStateMixin {
  final List<Tab> tabs = const <Tab>[
    Tab(text: ' Tổng Quan '),
    Tab(text: '  Chi Tiết '),
    Tab(text: '  Tài Liệu  ')
  ];

  TabController _tabController;
  AppBar _appBar;

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
    _appBar = AppBar(
      iconTheme: IconThemeData(
        color: AppColors.labelLightGreyColor, //change your color here
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
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
        controller: _tabController
      ),
    );
    return Scaffold(
      appBar: _appBar,
      body: Container(
        color: Colors.white,
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            ConferenceOverview(
              conference: widget.conference,
              apiConfig: widget.apiConfig,
              token: widget.token
            ),
            PdfViewer(
              url: 'http://hosrem.org.vn/public/frontend/upload/YHSS_47/02.pdf',
              top: _appBar.preferredSize.height + MediaQuery.of(context).padding.top,
              width: _calculatePdfWidth(context),
              height: _calculatePdfHeight(context),
            ),
            ConferenceResources(widget.conference)
          ]
        )
      )
    );
  }

  double _calculatePdfHeight(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double top = _appBar.preferredSize.height;
    double height = mediaQuery.size.height - top;
    if (height < 0.0) {
      height = 0.0;
    }

    return height;
  }

  double _calculatePdfWidth(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.width;
  }
}
