import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/survey/question.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/widget/svg/svg_icon.dart';


/// Survey Question widget.
@immutable
class SurveyQuestion extends StatelessWidget {
  const SurveyQuestion(this.question, { this.value, this.rateChanged, this.enable = true, this.selectColor = AppColors.lightPrimaryColor });

  final Question question;
  final String value;
  final Function(String) rateChanged;
  final bool enable;
  final Color selectColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            question.title,
            style: TextStyles.textStyle20PrimaryBlack
          ),
          const SizedBox(height: 24.0),
          const Text(
            'Vui lòng đánh giá từ 1 (tệ nhất) đến 5 (tốt nhất).',
            style: TextStyles.textStyle14PrimaryBlack
          ),
          const SizedBox(height: 25.0),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  child: Column(
                    children: <Widget>[
                      SvgIcon(
                        value == '1' ? AppAssets.emote1Selected : AppAssets.emote1Normal,
                        size: 42.0,
                        color: value == '1' ? selectColor : AppColors.secondaryGreyColor
                      ),
                      const SizedBox(height: 6.0),
                      const Text('1', textAlign: TextAlign.center, style: TextStyles.textStyle16PrimaryBlack)
                    ],
                  ),
                  onTap: () => rateChanged == null || !enable ? null : rateChanged('1'),
                ),
                InkWell(
                  child: Column(
                    children: <Widget>[
                      SvgIcon(
                        value == '2' ? AppAssets.emote2Selected : AppAssets.emote2Normal,
                        size: 42.0,
                        color: value == '2' ? selectColor : AppColors.secondaryGreyColor
                      ),
                      const SizedBox(height: 6.0),
                      const Text('2', textAlign: TextAlign.center, style: TextStyles.textStyle16PrimaryBlack)
                    ],
                  ),
                  onTap: () => rateChanged == null || !enable ? null : rateChanged('2')
                ),
                InkWell(
                  child: Column(
                    children: <Widget>[
                      SvgIcon(
                        value == '3' ? AppAssets.emote3Selected : AppAssets.emote3Normal,
                        size: 42.0,
                        color: value == '3' ? selectColor : AppColors.secondaryGreyColor
                      ),
                      const SizedBox(height: 6.0),
                      const Text('3', textAlign: TextAlign.center, style: TextStyles.textStyle16PrimaryBlack)
                    ],
                  ),
                  onTap: () => rateChanged == null || !enable ? null : rateChanged('3')
                ),
                InkWell(
                  child: Column(
                    children: <Widget>[
                      SvgIcon(
                        value == '4' ? AppAssets.emote4Selected : AppAssets.emote4Normal,
                        size: 42.0,
                        color: value == '4' ? selectColor :  AppColors.secondaryGreyColor
                      ),
                      const SizedBox(height: 6.0),
                      const Text('4', textAlign: TextAlign.center, style: TextStyles.textStyle16PrimaryBlack)
                    ],
                  ),
                  onTap: () => rateChanged == null || !enable ? null : rateChanged('4')
                ),
                InkWell(
                  child: Column(
                    children: <Widget>[
                      SvgIcon(
                        value == '5' ? AppAssets.emote5Selected : AppAssets.emote5Normal,
                        size: 42.0,
                        color: value == '5' ? selectColor : AppColors.secondaryGreyColor
                      ),
                      const SizedBox(height: 6.0),
                      const Text('5', textAlign: TextAlign.center, style: TextStyles.textStyle16PrimaryBlack)
                    ],
                  ),
                  onTap: () => rateChanged == null || !enable ? null : rateChanged('5')
                )
              ],
            )
          ),
          const SizedBox(height: 32.0)
        ],
      ),
    );
  }
}
