
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/notification/notification.dart' as alert;
import 'package:hosrem_app/common/text_styles.dart';
import 'package:timeago/timeago.dart' as timeago;

/// Notification Item.
@immutable
class NotificationItem extends StatelessWidget {
  const NotificationItem({this.notification, this.onTap});

  final alert.Notification notification;
  final Function onTap;

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
                Icon(Icons.person_outline, size: 26.3),
                const SizedBox(width: 28.0),
                Expanded(
                  child: Container(
                    child: Text(
                      notification.message,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.textStyle14PrimaryBlack
                    )
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
                  style: TextStyles.textStyle11PrimaryBlack
                )
              ]
            )
          ],
        )
      ),
      onTap: onTap
    );
  }
}