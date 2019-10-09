import 'package:flutter/material.dart';
import 'package:hosrem_app/api/conference/conference_resource.dart';
import 'package:hosrem_app/common/app_colors.dart';

/// Conference resource item.
@immutable
class ConferenceResourceItem extends StatelessWidget {
  const ConferenceResourceItem(this.conferenceResource);

  final ConferenceResource conferenceResource;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'HỘI CHỨNG BUỒNG TRỨNG ĐA NANG 2017',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.editTextFieldTitleColor
            )
          ),
          const SizedBox(height: 10.0),
          const Text(
            'Hồ Mạnh Tường',
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.editTextFieldTitleColor
            )
          )
        ],
      )
    );
  }
}
