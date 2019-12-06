import 'package:flutter/material.dart';
import 'package:hosrem_app/api/conference/public_registration.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/config/api_config.dart';
import 'package:hosrem_app/widget/svg/svg_icon.dart';

/// SearchRegisteredUsers item.
@immutable
class SearchRegisteredUsersItem extends StatelessWidget {
  const SearchRegisteredUsersItem(this.participate, this.apiConfig);

  final PublicRegistration participate;
  final ApiConfig apiConfig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: AppColors.boxShadowColor,
            offset: Offset(0.0, 2.0),
            blurRadius: 4.0,
            spreadRadius: 0.0
          )
        ],
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 12.0, right: 10.0, left: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        participate.fullName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.textStyle18PrimaryBlack
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        participate.company ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.textStyle14SecondaryGrey
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      participate.registrationPaymentStatus != null &&  participate.registrationPaymentStatus == 'Completed' ? Container(
                        transform: Matrix4.translationValues(17.0, -7.0, 0.0),
                        child: const SvgIcon(AppAssets.registered_icons)
                      ) : Container(
                        transform: Matrix4.translationValues(17.0, -7.0, 0.0),
                        child: const SvgIcon(AppAssets.pending_icon)
                      ),
                      const Text('')
                    ],
                  ),
                ),
              ],
            )
          ),
        ],
      )
    );
  }

}
