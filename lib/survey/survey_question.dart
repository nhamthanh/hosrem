import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/survey/question.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/widget/rating/rating_widget.dart';


/// Survey Question widget.
@immutable
class SurveyQuestion extends StatelessWidget {
  const SurveyQuestion(this.question, { this.value, this.rateChanged, this.enable = true });

  final Question question;
  final String value;
  final Function(String) rateChanged;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            question.title,
            style: TextStyles.textStyle20PrimaryBlack
          ),
          const SizedBox(height: 24.0),
          const Text(
            'Vui lòng đánh giá từ 1 (tệ nhất) đến 5 (tốt nhất).',
            style: TextStyles.textStyle14PrimaryBlack
          ),
          const SizedBox(height: 25.0),
          RatingWidget(rateChanged, value: value,  enable: enable),
          const SizedBox(height: 32.0)
        ],
      ),
    );
  }
}
