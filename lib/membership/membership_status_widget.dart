import 'package:flutter/material.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/membership/user_membership.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/date_time_utils.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/widget/svg/svg_icon.dart';

/// Membership status widget.
@immutable
class MembershipStatusWidget extends StatelessWidget {
  const MembershipStatusWidget({this.user, this.userMembership});

  final User user;
  final UserMembership userMembership;

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Container();
    }

    if (userMembership == null) {
      return _standardMemberWidget();
    }

    if (userMembership.status != 'Valid') {
      return _standardMemberWidget(expiredTime: userMembership.expiredTime);
    }

    return _premiumMemberWidget(userMembership);
  }

  Widget _premiumMemberWidget(UserMembership userMembership) {
    final DateTime current = DateTime.now().add(Duration(days: 30));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 19.5, horizontal: 28.0),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: SvgIcon(AppAssets.diamondIcon, size: 37.0)
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Hội Viên HOSREM',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.textStyle16PrimaryBlue
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Ngày hết hạn ',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.textStyle13PrimaryGrey
                    ),
                    Text(
                      '${DateTimeUtils.formatAsStandard(userMembership.expiredTime)}.',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: current.isAfter(userMembership.expiredTime) ? TextStyles.textStyle13PrimaryRed : TextStyles.textStyle13PrimaryGrey
                    ),
                    const SizedBox(width: 5.0),
                    Expanded(
                      child: Text(
                        current.isAfter(userMembership.expiredTime) ? 'Gia hạn ngay' : '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.textStyle13PrimaryBlue
                      ),
                    )
                  ],
                )
              ],
            )
          )
        ],
      )
    );
  }

  Widget _standardMemberWidget({ DateTime expiredTime }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 19.5, horizontal: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Thành Viên Bình Thường',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.textStyle16SecondaryGreyBold
          ),
          expiredTime == null ? const Text(
            'Nâng Cấp Thành Hội Viên HOSREM',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.textStyle13PrimaryBlue
          ) : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Đã hết hạn ngày ',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.textStyle13PrimaryGrey
              ),
              Text(
                '${DateTimeUtils.formatAsStandard(userMembership.expiredTime)}.',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.textStyle13PrimaryRed
              ),
              const SizedBox(width: 5.0),
              const Expanded(
                child: Text(
                  'Gia hạn ngay',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.textStyle13PrimaryBlue
                ),
              )
            ],
          ),
        ]
      )
    );
  }
}
