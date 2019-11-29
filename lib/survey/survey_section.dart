import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/survey/question.dart';
import 'package:hosrem_app/api/survey/section.dart';
import 'package:hosrem_app/common/app_colors.dart';

import 'survey_question.dart';
import 'survey_section_header.dart';
import 'survey_text_question.dart';


/// SurveySection page.
class SurveySection extends StatelessWidget {
  const SurveySection(this.section, { this.enable = true, this.values = const <Question, String>{}, this.rateChanged });

  final Section section;
  final Map<Question, String> values;
  final Function(Question, String) rateChanged;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 6.0),
          SurveySectionHeader(section),
          const SizedBox(height: 24.0),
          Column(
            children: section.questions.map(_buildSurveyQuestion).toList()
          )
        ],
      )
    );
  }

  Widget _buildSurveyQuestion(Question question) {

    if (question.answerType == 'FreeText') {
      return SurveyTextQuestion(
        question,
        value: values[question],
        textChanged: (String value) => rateChanged == null ? null : rateChanged(question, value),
        enable: enable,
      );
    }

    return SurveyQuestion(
      question,
      value: values[question],
      rateChanged: (String value) => rateChanged == null ? null : rateChanged(question, value),
      enable: enable,
    );
  }
}
