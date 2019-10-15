import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/app/app_routes.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/widget/button/default_button.dart';
import 'package:hosrem_app/widget/navigator/navigator_item.dart';

import 'update_profile.dart';

/// Profile page.
@immutable
class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends BaseState<Profile> {
  AuthService _authService;

  @override
  void initState() {
    super.initState();

    _authService = AuthService(apiProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 20.0),
          Container(
            padding: const EdgeInsets.all(28.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 108.0,
                  height: 108.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightPrimaryColor
                  ),
                  child: Icon(Icons.person, size: 80.0, color: Colors.white),
                ),
                const SizedBox(width: 28.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'TS.BS Hồ Mạnh Tường',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20.0,
                          height: 1.6,
                          color: AppColors.editTextFieldTitleColor
                        )
                      ),
                      Text(
                        'Hết hạn ngày 20/11/2019',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.0,
                          height: 2,
                          color: AppColors.editTextFieldTitleColor
                        )
                      ),
                      const SizedBox(height: 10.0),
                      FlatButton(
                        child: Text(
                          'Premium Member',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.lightPrimaryColor
                          )
                        ),
                        textColor: AppColors.lightPrimaryColor,
                        onPressed: () {},
                        color: const Color.fromRGBO(105, 192, 255, 0.2),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: AppColors.lightPrimaryColor,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(18.0))
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 20.0,
            color: const Color(0xFFF5F8FA),
          ),
          NavigatorItem(
            text: AppLocalizations.of(context).tr('profile.your_profile'),
            icon: Icons.person_outline,
            onTap: _navigateToProfile,
          ),
          NavigatorItem(
            text: AppLocalizations.of(context).tr('profile.change_your_password'),
            icon: Icons.lock_outline,
          ),
          NavigatorItem(
            text: AppLocalizations.of(context).tr('profile.my_registered_events'),
            icon: Icons.event
          ),
          NavigatorItem(text: AppLocalizations.of(context).tr('profile.my_favorites_domains')),
          const SizedBox(height: 40.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: DefaultButton(
                  backgroundColor: AppColors.lightPrimaryColor,
                  text: AppLocalizations.of(context).tr('profile.logout'),
                  onPressed: _onLogoutButtonPressed,
                )
              )
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute<bool>(builder: (BuildContext context) => UpdateProfile())
    );
  }

  void _onLogoutButtonPressed() {
    _authService.deleteToken();
    appContext.router.navigateTo(context, AppRoutes.loginRoute, clearStack:true, transition: TransitionType.fadeIn);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
