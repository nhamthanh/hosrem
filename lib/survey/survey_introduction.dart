import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';

import 'survey.dart';

/// Survey introduction page.
class SurveyIntroduction extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Khảo sát'),
        automaticallyImplyLeading: false
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 100.0),
                    Image.asset(AppAssets.surveyImage),
                    const SizedBox(height: 52.0),
                    Text(
                      'Please take a few minutes to fill out a short survey :)',
                      textAlign: TextAlign.center,
                      style: TextStyles.textStyle20PrimaryBlack
                    )
                  ],
                )
              )
            ),
            Container(
              height: 10.0,
              color: AppColors.backgroundConferenceColor,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(top: const BorderSide(width: 1.0, color: AppColors.editTextFieldBorderColor)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(left: 25.0, top: 28.5, bottom: 28.5, right: 25.0),
              child: PrimaryButton(
                text: 'Bắt Đầu',
                onPressed: () => _navigateToSurveySection(context),
              )
            )
          ],
        )
      )
    );
  }

  void _navigateToSurveySection(BuildContext context) {
    Navigator.push(context, MaterialPageRoute<bool>(builder: (BuildContext context) => const Survey('123')));
  }
}
