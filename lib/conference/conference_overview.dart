import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/date_time_utils.dart';
import 'package:hosrem_app/config/api_config.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';

/// Conference detail page.
@immutable
class ConferenceOverview extends StatelessWidget {
  const ConferenceOverview({Key key, this.conference, this.apiConfig, this.token}) : super(key: key);

  final Conference conference;
  final String token;
  final ApiConfig apiConfig;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(28.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                conference.title ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 18.0, color: AppColors.editTextFieldTitleColor, height: 1.5)
                              ),
                              const SizedBox(height: 8.0),
                              Row(
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
                              ),
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
                                  conference.startTime == null ? '' : DateTimeUtils.format(conference.startTime),
                                  style: TextStyle(fontSize: 10.0, color: AppColors.labelHighlightColor, height: 1.33)),
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.all(28.0),
                    child: CachedNetworkImage(
                      imageUrl: conference.banner != null ? '${apiConfig.apiBaseUrl}files/${conference.banner}?token=$token' : 'https://',
                      placeholder: (BuildContext context, String url) => Center(child: const CircularProgressIndicator()),
                      errorWidget: (BuildContext context, String url, Object error) =>
                        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                          Container(
                            height: 168.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color.fromRGBO(52, 169, 255, 0.1)
                            ),
                            child: Image.asset('assets/images/conference_placeholder.png'))
                        ])),
                  ),
                  Container(
                    height: 20.0,
                    color: const Color(0xFFF5F8FA),
                  ),
                  const SizedBox(height: 9.0),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).tr('conferences.about_event'),
                          style: TextStyle(fontSize: 16.0, color: AppColors.editTextFieldTitleColor, fontWeight: FontWeight.w600)
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          conference.description ?? '',
                          style: TextStyle(fontSize: 16.0, color: AppColors.editTextFieldTitleColor, height: 1.5)
                        )
                      ],
                    )
                  ),
                  Container(
                    height: 20.0,
                    color: const Color(0xFFF5F8FA),
                  ),
                  const SizedBox(height: 17.0),
                  Container(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0, top: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Phí tham gia đối với hội viên HOSREM',
                          style: TextStyle(fontSize: 16.0, color: const Color(0xFF002029), fontWeight: FontWeight.w600)
                        ),
                        const SizedBox(height: 17.0),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.editTextFieldBorderColor)
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Đăng ký trước',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: const Color(0xFF002029))
                                          ),
                                          Text(
                                            '08/11/2019',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: const Color(0xFF002029))
                                          )
                                        ],
                                      )
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          '2.000.000 đ/người',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: const Color(0xFF002029))
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ),
                              const Divider(),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Đăng ký từ',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: const Color(0xFF002029))
                                          ),
                                          Text(
                                            '9/11 - 21/11/2019',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: const Color(0xFF002029))
                                          )
                                        ],
                                      )
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          '2.250.000 đ/người',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: const Color(0xFF002029))
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ),
                              const Divider(),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Đăng ký từ',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: const Color(0xFF002029))
                                          ),
                                          Text(
                                            '22/11/2019',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: const Color(0xFF002029))
                                          )
                                        ],
                                      )
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          '2.500.000 đ/người',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: const Color(0xFF002029))
                                        )
                                      ],
                                    )
                                  ],
                                )
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 22.0),
                        Text(
                          'Phí tham gia cho đối tượng khác',
                          style: TextStyle(fontSize: 16.0, color: const Color(0xFF002029), fontWeight: FontWeight.w600)
                        ),
                        const SizedBox(height: 17.0),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.editTextFieldBorderColor)
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Đăng ký trước',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: const Color(0xFF002029))
                                          ),
                                          Text(
                                            '08/11/2019',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: const Color(0xFF002029))
                                          )
                                        ],
                                      )
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          '2.200.000 đ/người',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: const Color(0xFF002029))
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ),
                              const Divider(),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Đăng ký từ',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: const Color(0xFF002029))
                                          ),
                                          Text(
                                            '09/11 - 21/11/2019',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: const Color(0xFF002029))
                                          )
                                        ],
                                      )
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          '2.450.000 đ/người',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: const Color(0xFF002029))
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ),
                              const Divider(),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Đăng ký từ',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: const Color(0xFF002029))
                                          ),
                                          Text(
                                            '22/11/2019',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: const Color(0xFF002029))
                                          )
                                        ],
                                      )
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          '2.700.000 đ/người',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: const Color(0xFF002029))
                                        )
                                      ],
                                    )
                                  ],
                                )
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ),
                  const SizedBox(height: 20.0),
                ],
              )
            )
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.only(left: 25.0, top: 28.5, bottom: 28.5, right: 25.0),
            color: Colors.white,
            child: PrimaryButton(
              text: AppLocalizations.of(context).tr('conferences.register_for_event'),
              onPressed: () {
              },
            )
          )
        ],
      )
    );
  }
}
