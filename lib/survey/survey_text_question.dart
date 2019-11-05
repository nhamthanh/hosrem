import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/survey/question.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/widget/text/edit_text_field.dart';


/// Survey text question widget.
@immutable
class SurveyTextQuestion extends StatelessWidget {
  SurveyTextQuestion(this.question, { Key key, String value, this.textChanged })
      : _feedbackController = TextEditingController(text: value), super(key: key);

  final Question question;
  final Function(String) textChanged;

  final TextEditingController _feedbackController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            question.content,
            style: TextStyles.textStyle20PrimaryBlack
          ),
          const SizedBox(height: 24.0),
          Text(
            'Vui lòng đánh giá từ 1 (tệ nhất) đến 5 (tốt nhất).',
            style: TextStyles.textStyle14PrimaryBlack
          ),
          const SizedBox(height: 25.0),
          Container(
            child: EditTextField(
              title: '',
              hint: '',
              hasLabel: false,
              controller: _feedbackController,
              onTextChanged: textChanged,
              line: 5
            )
          )
        ],
      ),
    );
  }
}
