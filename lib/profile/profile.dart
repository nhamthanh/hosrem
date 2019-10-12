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
      padding: const EdgeInsets.only(left: 15.0),
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 20.0),
          NavigatorItem(
            text: AppLocalizations.of(context).tr('profile.your_profile'),
            icon: Icons.person_outline,
            onTap: _navigateToProfile,
          ),
          const Divider(),
          NavigatorItem(
            text: AppLocalizations.of(context).tr('profile.change_your_password'),
            icon: Icons.lock_outline,
          ),
          const Divider(),
          NavigatorItem(
            text: AppLocalizations.of(context).tr('profile.my_registered_events'),
            icon: Icons.event
          ),
          const Divider(),
          NavigatorItem(text: AppLocalizations.of(context).tr('profile.my_favorites_domains')),
          const SizedBox(height: 40.0),
          Row(
            children: <Widget>[
              Expanded(
                child: DefaultButton(
                  backgroundColor: AppColors.lightPrimaryColor,
                  text: AppLocalizations.of(context).tr('profile.logout'),
                  onPressed: _onLogoutButtonPressed,
                )
              ),
              const SizedBox(width: 15.0)
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
