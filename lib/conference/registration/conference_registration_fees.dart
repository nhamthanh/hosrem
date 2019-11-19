import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  final GlobalKey key = GlobalKey();
  TabController _tabController;
  double maxHeight = 20.0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 2);
    //Calculate height of fees area
    WidgetsBinding.instance.addPostFrameCallback((_) => getHeight());
  }

  void getHeight() {
    final State state = key.currentState;
    final RenderFlex box = state.context.findRenderObject();
    final List<RenderBox> child = box.getChildrenAsList();
    for (int i = 0; i < child.length; i++) {
      maxHeight += child[i].size.height;
    }
    setState(() {
      maxHeight = maxHeight;
    });
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
            height: maxHeight,
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                ConferenceRegistrationFeeWidget(
                  key: key,
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
