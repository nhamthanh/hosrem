import 'package:flutter/material.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/text_styles.dart';

/// Edit text field.
@immutable
class EditTextField extends StatelessWidget {
  const EditTextField({this.title, this.hint, this.obscureText = false, this.prefixIcon, this.hasLabel = true,
    this.controller, this.onTextChanged, this.error});

  final String title;
  final String hint;
  final String error;
  final bool hasLabel;
  final bool obscureText;
  final Widget prefixIcon;
  final Function onTextChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        hasLabel ? Text(
          title,
          style: TextStyles.textStyle16PrimaryBlack,
        ) : Container(),
        hasLabel ? const SizedBox(height: 10) : Container(),
        Container(
          height: 50.0,
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: const EdgeInsets.fromLTRB(13.0, 11.0, 5.0, 11.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: const BorderSide(color: AppColors.editTextFieldBorderColor, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: const BorderSide(color: AppColors.editTextFieldBorderColor, width: 1.0),
              ),
              prefixIcon: prefixIcon == null ? null : prefixIcon,
              fillColor: Colors.white,
              filled: true
            ),
            obscureText: obscureText,
            onChanged: onTextChanged,
            controller: controller,
            style: TextStyles.textStyle16PrimaryGrey
          )
        ),
        error != null ? Text(error, style: TextStyles.textStyle14PrimaryRed) : Container()
      ]
    );
  }
}
