import 'package:flutter/material.dart';
import 'package:hosrem_app/common/app_colors.dart';

/// Primary button.
@immutable
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({this.backgroundColor, this.text, this.onPressed});

  final Color backgroundColor;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.buttonShadowColor1,
            offset: const Offset(0.0, 2.0),
            blurRadius: 4.0,
            spreadRadius: -1.0
          ),
          BoxShadow(
            color: AppColors.buttonShadowColor2,
            offset: const Offset(0.0, 1.0),
            blurRadius: 10.0,
            spreadRadius: 1.0
          ),
          BoxShadow(
            color: AppColors.buttonShadowColor3,
            offset: const Offset(0.0, 4.0),
            blurRadius: 5.0,
            spreadRadius: 1.0
          )
        ],
        color: AppColors.lightPrimaryColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: FlatButton(
        child: Text(text),
        textColor: Colors.white,
        onPressed: onPressed,
      )
    );
  }
}
