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

  TabController _tabController;
  final GlobalKey key = GlobalKey<State<StatefulWidget>>();
  @override
  void initState() {
    super.initState();
    //calling the getHeight Function after the Layout is Rendered
    WidgetsBinding.instance
        .addPostFrameCallback((_) => getHeight());

    _tabController = TabController(vsync: this, length: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void getHeight(){

    final State state = key.currentState;
    //returns null:
    final BuildContext context = key.currentContext;

    //Error: The getter 'context' was called on null.
    final RenderFlex box = state.context.findRenderObject();
    print(box.size.height);
    print(context.size.height);
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
              //Container(child: Tab(text: AppLocalizations.of(context).tr('conferences.other_member')), width: 140.0)
            ],
            controller: _tabController
          ),
          const SizedBox(height: 5.0),
          Container(
            height: 10,
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                ConferenceRegistrationFeeWidget(
                  title: 'Phí tham gia đối với hội viên HOSREM',
                  conferenceFees: widget.conferenceFees.memberFees, key: key),
                // ConferenceRegistrationFeeWidget(
                //   title: 'Phí tham gia đối với đối tượng khác',
                //   conferenceFees: widget.conferenceFees.otherFees, key: key
                // )
              ]
            )
          )
        ]
      )
    );
  }
}
