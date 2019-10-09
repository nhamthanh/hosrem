import 'package:flutter/material.dart';
import 'package:hosrem_app/common/app_colors.dart';

/// Facebook button.
@immutable
class FacebookButton extends StatelessWidget {
  const FacebookButton({this.backgroundColor, this.text, this.onPressed});

  final Color backgroundColor;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        color: AppColors.facebookPrimaryColor,
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
