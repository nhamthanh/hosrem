import 'package:flutter/material.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/constants.dart';
import 'package:hosrem_app/widget/rating/rating_item.dart';

/// Rating Widget.
@immutable
class RatingWidget extends StatelessWidget {
  RatingWidget(this.rateChanged, {this.value = '', this.enable = true });

  final String value;

  final Function(String) rateChanged;

  final bool enable;

  final List<String> selectedIcons = <String>[AppAssets.emote1Selected, AppAssets.emote2Selected, AppAssets.emote3Selected, AppAssets.emote4Selected, AppAssets.emote5Selected];

  final List<String> normalIcons = <String>[AppAssets.emote1Normal, AppAssets.emote2Normal, AppAssets.emote3Normal, AppAssets.emote4Normal, AppAssets.emote5Normal];

  final List<String> ratingList = <String>[Constants.worst, Constants.bad, Constants.normal, Constants.good, Constants.best];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ratingList.map((String index) => RatingItem(index.toString(), rateChanged, index == value ? selectedIcons[int.parse(index) - 1] : normalIcons[int.parse(index) - 1], enable: enable, value: value)).toList(),
      )
    );
  }
}
