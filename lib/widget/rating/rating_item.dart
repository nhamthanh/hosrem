import 'package:flutter/material.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/widget/svg/svg_icon.dart';

/// Rating Item.
@immutable
class RatingItem extends StatelessWidget {
  const RatingItem(this.index, this.rateChanged, this.icon, {this.value = '', this.enable = true});

  final String value;

  final String index;

  final Function(String) rateChanged;

  final bool enable;

  final String icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: <Widget>[
          SvgIcon(
            icon,
            size: 42.0,
            color: index == value && enable ? AppColors.lightPrimaryColor : AppColors.secondaryGreyColor
          ),
          const SizedBox(height: 6.0),
          Text(index, textAlign: TextAlign.center, style: TextStyles.textStyle16PrimaryBlack)
        ],
      ),
      onTap: () => rateChanged == null || !enable ? null : rateChanged(index)
    );
  }
}
