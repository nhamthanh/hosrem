import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/common/app_colors.dart';

/// Conference item.
@immutable
class ConferenceItem extends StatelessWidget {
  const ConferenceItem(this.conference);

  final Conference conference;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      height: 300.0,
      child: Stack(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: 'http://hosrem.org.vn/public/frontend/images/photos/Banner_-_HNTN_2019-01.jpg',
            imageBuilder: (BuildContext context, ImageProvider imageProvider) => Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppColors.buttonShadowColor1,
                    offset: const Offset(0.0, 2.0),
                    blurRadius: 4.0,
                    spreadRadius: -1.0
                  ),
                  BoxShadow(
                    color: AppColors.buttonShadowColor2,
                    offset: const Offset(0.0, 1.0),
                    blurRadius: 10.0,
                    spreadRadius: 1.0
                  ),
                  BoxShadow(
                    color: AppColors.buttonShadowColor3,
                    offset: const Offset(0.0, 4.0),
                    blurRadius: 5.0,
                    spreadRadius: 1.0
                  )
                ],
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  colorFilter:
                  ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
              ),
            ),
            placeholder: (BuildContext context, String url) => CircularProgressIndicator(),
            errorWidget: (BuildContext context, String url, Object error) => Icon(Icons.error),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 100.0,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0)
                  ),
                  color: Color.fromRGBO(0, 0, 0, 0.6) // Specifies the background color and the opacity
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'HỘI NGHỊ KHOA HỌC THƯỜNG NIÊN HOSREM LẦN XV',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      )
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Khách sạn Equatorial, Chủ nhật ngày 3 tháng 11 năm 2019',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      )
                    )
                  ],
                ),
              )
            ],
          )
        ],
      )
    );
  }
}
