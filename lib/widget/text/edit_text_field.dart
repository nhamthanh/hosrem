import 'package:flutter/material.dart';
import 'package:hosrem_app/common/app_colors.dart';

/// Edit text field.
@immutable
class EditTextField extends StatelessWidget {
  const EditTextField({this.title, this.hint, this.obscureText = false, this.controller, this.onTextChanged});

  final String title;
  final String hint;
  final bool obscureText;
  final Function onTextChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 14.0,
            color: AppColors.editTextFieldTitleColor
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 42.0,
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: const EdgeInsets.fromLTRB(15.0, 11.0, 20.0, 11.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: AppColors.editTextFieldBorderColor, width: 1.5),
              ),
            ),
            obscureText: obscureText,
            onChanged: onTextChanged,
            controller: controller,
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.editTextFieldTitleColor
            )
          )
        )
      ]
    );
  }
}
