import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:hosrem_app/api/conference/conference_fee.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:collection/collection.dart';
import 'package:hosrem_app/widget/svg/svg_icon.dart';

/// Conference registration fee widget.
@immutable
class ConferenceRegistrationFeeWidget extends StatelessWidget {
  const ConferenceRegistrationFeeWidget({Key key, @required this.title, @required this.conferenceFees})
    : assert(title != null), assert(conferenceFees != null), super(key: key);

  final List<ConferenceFee> conferenceFees;
  final String title;

  @override
  Widget build(BuildContext context) {
    final Map<DateTime, List<ConferenceFee>> groupByMilestoneFees =
        groupBy(conferenceFees, (ConferenceFee conferenceFee) => conferenceFee.milestone);
    final List<DateTime> milestones = groupByMilestoneFees.keys.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyles.textStyle16SecondaryBlackBold
        ),
        const SizedBox(height: 17.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.editTextFieldBorderColor)
          ),
          child: Column(
            children: milestones.map((DateTime milestone) => Column(
              children: <Widget>[
                milestones.indexOf(milestone) == 0 ? Container() : const Divider(),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          groupByMilestoneFees[milestone][0]?.description ?? '',
                          style: TextStyles.textStyle11SecondaryBlack
                        )
                      ),
                      const SizedBox(width: 20.0),
                      _buildFeeColumn(milestone, groupByMilestoneFees[milestone])
                    ],
                  )
                ),

              ],
            )).toList(),
          ),
        )
      ],
    );
  }

  Column _buildFeeColumn(DateTime milestone, List<ConferenceFee> conferenceFees) {
    MoneyFormatterSettings moneyFormatterSettings = MoneyFormatterSettings(
      thousandSeparator: '.',
      decimalSeparator: ',',
      symbolAndNumberSeparator: ' '
    );

    return Column(
      children: conferenceFees.map((ConferenceFee conferenceFee) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  FlutterMoneyFormatter(
                    amount: conferenceFee.fee,
                    settings: moneyFormatterSettings
                  ).output.withoutFractionDigits,
                  style: TextStyles.textStyle14SecondaryBlack
                ),
                Text(
                  'đ / người',
                  style: TextStyles.textStyle9SecondaryBlack
                )
              ],
            )
          ),
          const SizedBox(width: 17.0),
          Container(
            width: 40.0,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 5.0),
                SvgIcon(
                  conferenceFee.letterType == 'Email' ? AppAssets.emailIcon : AppAssets.noticeIcon,
                  size: 14,
                  color: AppColors.tertiaryGreyColor
                ),
                Text(
                  conferenceFee.letterType == 'Email' ? '(thư điện tử)' : '(thư in đẹp)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.tertiaryGreyColor,
                    fontSize: 9.0
                  )
                )
              ],
            )
          )
        ]
      )).toList()
    );
  }
}
