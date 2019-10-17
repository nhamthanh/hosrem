import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/app/app_routes.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/login/login.dart';
import 'package:hosrem_app/widget/button/default_button.dart';
import 'package:hosrem_app/widget/navigator/navigator_item.dart';
import 'package:page_transition/page_transition.dart';

import 'bloc/profile_bloc.dart';
import 'bloc/profile_event.dart';
import 'bloc/profile_state.dart';
import 'update_profile.dart';

/// Profile page.
@immutable
class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends BaseState<Profile> {
  AuthService _authService;
  ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();

    _authService = AuthService(apiProvider);
    _profileBloc = ProfileBloc(authService: AuthService(apiProvider));
    _profileBloc.dispatch(LoadProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      builder: (BuildContext context) => _profileBloc,
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (BuildContext context, ProfileState state) {
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: _profileBloc,
          builder: (BuildContext context, ProfileState state) {
            final User user = state is ProfileSuccess ? state.user : null;
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
                                '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  height: 1.6,
                                  color: AppColors.primaryBlackColor
                                )
                              ),
                              Text(
                                '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  height: 2,
                                  color: AppColors.primaryBlackColor
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
                    onTap: () => _navigateToProfile(user),
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
                      user == null ? Container() : Container(
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
        )
      )
    );


  }

  void _navigateToProfile(User user) {
    Navigator.push<dynamic>(context, PageTransition<dynamic>(
      type: PageTransitionType.downToUp,
      child: user == null ? Login() : UpdateProfile()
    ));
  }

  void _onLogoutButtonPressed() {
    _authService.clearUser();
    apiProvider.cacheManager.emptyCache();
    appContext.router.navigateTo(context, AppRoutes.homeRoute, clearStack:true, transition: TransitionType.fadeIn);
  }

  @override
  void dispose() {
    _profileBloc.dispose();
    super.dispose();
  }
}
