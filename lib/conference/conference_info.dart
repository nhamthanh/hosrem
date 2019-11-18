
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/common/text_styles.dart';

// ConferenceInfo class
class ConferenceInfo extends StatelessWidget {

  const ConferenceInfo(this.conference);

  final Conference conference;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).tr('conferences.about_event'),
            style: TextStyles.textStyle16PrimaryBlackBold
          ),
          const SizedBox(height: 10.0),
          Text(
            conference.description ?? '',
            style: TextStyles.textStyle16PrimaryBlack
          ),
        ],
      )
    );         
  }
}