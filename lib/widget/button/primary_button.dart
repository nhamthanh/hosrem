import 'package:flutter/material.dart';
import 'package:hosrem_app/common/app_colors.dart';

/// Primary button.
@immutable
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({this.backgroundColor, this.text, this.onPressed, this.height = 50.0, this.hasShadow = true, this.fontSize = 16, this.fontWeight = FontWeight.normal});

  final Color backgroundColor;
  final String text;
  final Function onPressed;
  final double height;
  final bool hasShadow;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        boxShadow: hasShadow ? const <BoxShadow>[
          BoxShadow(
            color: AppColors.buttonShadowColor1,
            offset: Offset(0.0, 2.0),
            blurRadius: 4.0,
            spreadRadius: -1.0
          ),
          BoxShadow(
            color: AppColors.buttonShadowColor2,
            offset: Offset(0.0, 1.0),
            blurRadius: 10.0,
            spreadRadius: 1.0
          ),
          BoxShadow(
            color: AppColors.buttonShadowColor3,
            offset: Offset(0.0, 4.0),
            blurRadius: 5.0,
            spreadRadius: 1.0
          )
        ] : <BoxShadow>[],
        color: AppColors.lightPrimaryColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: FlatButton(
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        ),
        textColor: Colors.white,
        onPressed: onPressed
      )
    );
  }
}
