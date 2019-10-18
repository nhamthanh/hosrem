import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/api/conference/conference_fees.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/text_styles.dart';

import 'conference_registration_fee_widget.dart';

/// Conference registration fees page.
@immutable
class ConferenceRegistrationFees extends StatefulWidget {
  const ConferenceRegistrationFees(this.conferenceFees);

  final ConferenceFees conferenceFees;

  @override
  _ConferenceRegistrationFeesState createState() => _ConferenceRegistrationFeesState();
}

class _ConferenceRegistrationFeesState extends BaseState<ConferenceRegistrationFees>
    with SingleTickerProviderStateMixin {
  final List<Widget> tabs = <Widget>[
    Container(child: const Tab(text: 'Hội Viên HOSREM'), width: 140.0),
    Container(child: const Tab(text: 'Đối Tượng Khác'), width: 140.0)
  ];

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
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 5.0),
          TabBar(
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
          const SizedBox(height: 5.0),
          Container(
            height: 800.0,
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                ConferenceRegistrationFeeWidget(
                  title: 'Phí tham gia đối với hội viên HOSREM',
                  conferenceFees: widget.conferenceFees.memberFees),
                ConferenceRegistrationFeeWidget(
                  title: 'Phí tham gia đối với đối tượng khác',
                  conferenceFees: widget.conferenceFees.otherFees
                )
              ]
            )
          )

        ]
      )
    );
  }
}
