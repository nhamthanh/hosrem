import 'package:flutter/material.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/text_styles.dart';

/// Article category header.
@immutable
class ArticleCategoryHeader extends StatelessWidget {
  const ArticleCategoryHeader({ Key key, this.title = 'Hot News', this.onTapSeeAll }) : super(key: key);

  final String title;
  final Function() onTapSeeAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 19.0, horizontal: 7.0),
      color: AppColors.backgroundConferenceColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  style: TextStyles.textStyle22PrimaryBlack
                )
              ),
              InkWell(
                child: Text(
                  'See All',
                  style: TextStyles.textStyle14PrimaryBlue
                ),
                onTap: onTapSeeAll,
              )
            ]
          )
        ]
      )
    );
  }
}
