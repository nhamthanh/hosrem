import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:easy_localization/easy_localization_delegate.dart';
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

  TabController _tabController;
  int maxUnit = 1;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 2);
    //Calculate height of fees area
    maxUnit = widget.conferenceFees.memberFees.length > widget.conferenceFees.otherFees.length ?
      widget.conferenceFees.memberFees.length : widget.conferenceFees.otherFees.length;
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
            tabs: <Widget>[
              Container(child: Tab(text: AppLocalizations.of(context).tr('conferences.hosrem_member')), width: 140.0),
              Container(child: Tab(text: AppLocalizations.of(context).tr('conferences.other_member')), width: 140.0)
            ],
            controller: _tabController
          ),
          const SizedBox(height: 5.0),
          Container(
            height: 100.0 + (maxUnit * 47),
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
