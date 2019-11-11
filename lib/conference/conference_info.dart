import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/date_time_utils.dart';
import 'package:hosrem_app/common/text_styles.dart';

// ConferenceInfo class
class ConferenceInfo extends StatefulWidget{

  const ConferenceInfo(this.conference);

  final Conference conference;

  @override
  _ConferenceInfoState createState() => _ConferenceInfoState();
}

class _ConferenceInfoState extends State<ConferenceInfo> with SingleTickerProviderStateMixin {

  final List<Widget> tabs = <Widget>[
    Container(child: const Tab(text: 'Thông Tin'), width: 140.0),
    Container(child: const Tab(text: 'Thời Gian Và Địa Chỉ'), width: 150.0),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 28.0, right: 27.0, bottom: 0.0, top: 0.0),
            child: TabBar(
              isScrollable: true,
              unselectedLabelColor: AppColors.unselectLabelColor,
              labelStyle: TextStyles.textStyle16,
              unselectedLabelStyle: TextStyles.textStyle16,
              labelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BubbleTabIndicator(
                indicatorHeight: 36.0,
                indicatorColor: AppColors.primaryPurpleColor,
                indicatorRadius: 20.0,
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
              ),
              tabs: tabs,
              controller: _tabController
            ),
          ),
          Container(
            height: 245.0,
            padding: const EdgeInsets.only(left: 28.0, right: 27.0, bottom: 0.0, top: 0.0),
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                _buildInfo(context),
                _buildAddressTime(context),
              ]
            ),
          ),
        ],
      )
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 14.0),
          Text(
            AppLocalizations.of(context).tr('conferences.conference'),
            style: TextStyles.textStyle16PrimaryBlackBold
          ),
          const SizedBox(height: 14.0),
          Text(
            widget.conference.description ?? '',
            style: TextStyles.textStyle16PrimaryBlack
          ),
        ],
      )
    );         
  }

  Widget _buildAddressTime(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 14.0),
          Text(
            AppLocalizations.of(context).tr('conferences.address'),
            style: TextStyles.textStyle16PrimaryBlackBold
          ),
          const SizedBox(height: 14.0),
          Text(
            widget.conference.location ?? '',
            style: TextStyles.textStyle16PrimaryBlack,
            maxLines: 2,
          ),
          const SizedBox(height: 21.0),
          Text(
            AppLocalizations.of(context).tr('conferences.date_time'),
            style: TextStyles.textStyle16PrimaryBlackBold
          ),
          const SizedBox(height: 14.0),
          Text(
            DateTimeUtils.formatAsStandard(widget.conference.startTime) ?? '',
            style: TextStyles.textStyle16PrimaryBlack
          ),
          Text(
            DateTimeUtils.getTimeRange(widget.conference.startTime, widget.conference.endTime),
            style: TextStyles.textStyle16PrimaryBlack
          ),
        ],
      )
    );         
  }
}