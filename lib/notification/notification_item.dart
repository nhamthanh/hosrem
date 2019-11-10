
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/notification/notification.dart' as alert;
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/widget/svg/svg_icon.dart';
import 'package:timeago/timeago.dart' as timeago;

/// Notification Item.
@immutable
class NotificationItem extends StatelessWidget {
  const NotificationItem({this.notification, this.onTap});

  final alert.Notification notification;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                SvgIcon(
                  _getNotificationIcon(notification.notificationType),
                  size: 26.3,
                  color: notification.unread ? AppColors.primaryBlackColor : AppColors.tertiaryGreyColor
                ),
                const SizedBox(width: 28.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          notification.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: notification.unread ? TextStyles.textStyle14PrimaryBlackBold : TextStyles.textStyle14PrimaryBlack
                        )
                      ),
                      Container(
                        child: Text(
                          notification.message,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.textStyle14PrimaryBlack
                        )
                      )
                    ],
                  )
                )
              ]
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  timeago.format(notification.createdTime, locale: 'vi'),
                  style: notification.unread ? TextStyles.textStyle11PrimaryBlackBold : TextStyles.textStyle11PrimaryBlack
                )
              ]
            )
          ],
        )
      ),
      onTap: onTap
    );
  }

  String _getNotificationIcon(String notificationType) {
    if (notificationType == 'Conference') {
      return AppAssets.pencil;
    }

    return AppAssets.calendarIcon;
  }
}
