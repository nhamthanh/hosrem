import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/date_time_utils.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/config/api_config.dart';
import 'package:hosrem_app/widget/svg/svg_icon.dart';

/// Conference item.
@immutable
class ConferenceItem extends StatelessWidget {
  const ConferenceItem(this.conference, this.apiConfig, this.token, this.registeredConference);

  final Conference conference;
  final String token;
  final bool registeredConference;
  final ApiConfig apiConfig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.boxShadowColor,
            offset: const Offset(0.0, 2.0),
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
            padding: const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        conference.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.textStyle18PrimaryBlack
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: SvgIcon(AppAssets.locationIcon, size: 16.0, color: AppColors.secondaryGreyColor)
                          ),
                          const SizedBox(width: 5.0),
                          Expanded(
                            child: Text(
                              conference.location,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.textStyle14SecondaryGrey
                            )
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    const SizedBox(height: 7.0),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: SvgIcon(AppAssets.calendarIcon, size: 16.0, color: AppColors.secondaryGreyColor)
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          DateTimeUtils.format(conference.startTime),
                          style: TextStyles.textStyle10PrimaryRed
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      transform: Matrix4.translationValues(27.0, 0.0, 0.0),
                      child: _buildConferenceStatusWidget()
                    )
                  ],
                )
              ],
            )
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: CachedNetworkImage(
              height: 168.0,
              imageUrl: conference.banner != null ? '${apiConfig.apiBaseUrl}conferences/${conference.id}/banner' : 'https://',
              placeholder: (BuildContext context, String url) => Center(child: const CircularProgressIndicator()),
              errorWidget: (BuildContext context, String url, Object error) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: 168.0,
                    color: const Color.fromRGBO(52, 169, 255, 0.1),
                    child: Image.asset(AppAssets.conferencePlaceholder)
                  )
                ]
              )
            ),
          ),
        ],
      )
    );
  }

  Widget _buildConferenceStatusWidget() {
    if (registeredConference) {
      return SvgPicture.asset(AppAssets.registered_icons);
    }

    if (conference.status == 'Done') {
      return SvgPicture.asset(AppAssets.expired_icons);
    }

    return Container();
  }
}
