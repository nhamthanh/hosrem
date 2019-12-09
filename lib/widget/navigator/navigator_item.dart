import 'package:flutter/material.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/text_styles.dart';

/// Navigator Item.
@immutable
class NavigatorItem extends StatelessWidget {
  const NavigatorItem({this.text, this.icon, this.onTap});

  final String text;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.only(left: 28.0, top: 14.0, bottom: 14.0, right: 20.0),
        child: Row(children: <Widget>[
          Expanded(
            child: Text(
              text,
              style: TextStyles.textStyle20PrimaryBlack
            )
          ),
          IconButton(
            icon: Icon(
              Icons.keyboard_arrow_right,
              color: AppColors.primaryBlackColor,
              size: 24.0
            ),
            onPressed: onTap,
          ),
        ]),
      ),
      onTap: onTap
    );
  }
}
