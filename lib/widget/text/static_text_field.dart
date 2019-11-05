import 'package:flutter/material.dart';
import 'package:hosrem_app/common/text_styles.dart';

/// Static text field.
@immutable
class StaticTextField extends StatelessWidget {
  const StaticTextField(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        label.isNotEmpty ? Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyles.textStyle14PrimaryGrey,
        ) : Container(),
        Text(
          value ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyles.textStyle20PrimaryBlack,
        ),
      ]
    );
  }
}
