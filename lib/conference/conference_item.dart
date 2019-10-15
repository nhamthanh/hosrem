import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/date_time_utils.dart';
import 'package:hosrem_app/config/api_config.dart';

/// Conference item.
@immutable
class ConferenceItem extends StatelessWidget {
  const ConferenceItem(this.conference, this.apiConfig, this.token);

  final Conference conference;
  final String token;
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
                        style: TextStyle(fontSize: 18.0, color: AppColors.editTextFieldTitleColor, height: 1.5)
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.location_on, size: 16.0, color: AppColors.labelLightGreyColor),
                          const SizedBox(width: 5.0),
                          Expanded(
                            child: Text(
                              conference.location,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14.0, color: AppColors.labelLightGreyColor)
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
                        Icon(Icons.calendar_today, size: 16.0, color: AppColors.labelLightGreyColor),
                        const SizedBox(width: 5.0),
                        Text(
                          DateTimeUtils.format(conference.startTime),
                          style: TextStyle(
                            fontSize: 10.0,
                            color: AppColors.labelHighlightColor,
                            height: 1.33
                          )
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      transform: Matrix4.translationValues(27.0, 0.0, 0.0),
                      child: conference.status == 'Done' ? SvgPicture.asset('assets/images/expired.svg') : SvgPicture.asset('assets/images/registered.svg')
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
              imageUrl: conference.banner != null ? '${apiConfig.apiBaseUrl}files/${conference.banner}?token=$token' : 'https://',
              placeholder: (BuildContext context, String url) => Center(child: const CircularProgressIndicator()),
              errorWidget: (BuildContext context, String url, Object error) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: 168.0,
                    color: const Color.fromRGBO(52, 169, 255, 0.1),
                    child: Image.asset('assets/images/conference_placeholder.png')
                  )
                ]
              )
            ),
          ),
        ],
      )
    );
  }
}
