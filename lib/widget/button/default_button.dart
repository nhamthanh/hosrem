import 'package:flutter/material.dart';
import 'package:hosrem_app/common/app_colors.dart';

/// Simple round button.
@immutable
class DefaultButton extends StatelessWidget {
  const DefaultButton({this.backgroundColor, this.text, this.onPressed});

  final Color backgroundColor;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: OutlineButton(
        child: Text(text),
        textColor: AppColors.lightPrimaryColor,
        onPressed: onPressed,
        borderSide: BorderSide(
          color: AppColors.lightPrimaryColor,
          style: BorderStyle.solid,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))
      )
    );
  }
}
