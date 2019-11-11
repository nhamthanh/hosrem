import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/survey/section.dart';
import 'package:hosrem_app/common/text_styles.dart';

/// SurveySectionHeader page.
class SurveySectionHeader extends StatelessWidget {
  const SurveySectionHeader(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          section.name ?? '',
          style: TextStyles.textStyle22PrimaryBlueBold
        )
      ],
    );
  }
}
