import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/config/api_config.dart';
import 'package:hosrem_app/pdf/pdf_viewer.dart';

import 'conference_overview.dart';
import 'conference_resources.dart';
import 'document_service.dart';

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

class _ConferenceDetailState extends BaseState<ConferenceDetail> with SingleTickerProviderStateMixin {
  final List<Widget> tabs = <Widget>[
    Container(child: const Tab(text: 'Tổng Quan'), width: 80.0),
    Container(child: const Tab(text: 'Chi Tiết'), width: 80.0),
    Container(child: const Tab(text: 'Tài Liệu'), width: 80.0),
  ];

  TabController _tabController;
  AppBar _appBar;
  TabBar _tabBar;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);

    final AuthService authService = AuthService(apiProvider);
    final DocumentService documentService = DocumentService(apiProvider);
    authService.getToken().then((String token) => documentService.downloadAndCacheFiles(widget.conference.files, token));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _appBar = AppBar(
      title: Text(widget.conference.title),
      centerTitle: true,
    );
    _tabBar = TabBar(
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
      controller: _tabController
    );
    return Scaffold(
      appBar: _appBar,
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 5.0),
            _tabBar,
            const SizedBox(height: 5.0),
            Expanded(
              child: Container(
                color: Colors.white,
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    ConferenceOverview(
                      conference: widget.conference,
                      token: widget.token
                    ),
                    widget.conference.files.isNotEmpty ?
                    PdfViewer(
                      url: widget.conference.files.isNotEmpty ? '${apiConfig.apiBaseUrl}files/${widget.conference.files[0]}?token=${widget.token}' : 'http://',
//                      url: 'http://hosrem.org.vn/public/frontend/images/photos/GUIDELINES%20PCOS%201.0.pdf',
                      top: _appBar.preferredSize.height + MediaQuery.of(context).padding.top + _tabBar.preferredSize.height + 10.0,
                      width: _calculatePdfWidth(context),
                      height: _calculatePdfHeight(context),
                    ) : Center(
                      child: Text(
                        AppLocalizations.of(context).tr('conferences.details.no_document_found'),
                        style: TextStyles.textStyle16PrimaryBlack
                      )
                    ),
                    ConferenceResources(widget.conference)
                  ]
                )
              )
            )
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
