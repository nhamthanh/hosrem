import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/auth/degree.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/app/app_routes.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/login/login.dart';
import 'package:hosrem_app/profile/profile_details.dart';
import 'package:hosrem_app/widget/button/default_button.dart';
import 'package:hosrem_app/widget/navigator/navigator_item.dart';
import 'package:hosrem_app/widget/svg/svg_icon.dart';
import 'package:page_transition/page_transition.dart';

import 'bloc/profile_bloc.dart';
import 'bloc/profile_event.dart';
import 'bloc/profile_state.dart';

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
                    padding: const EdgeInsets.only(left: 30.0, right: 23.0, bottom: 23.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 108.0,
                          height: 108.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white
                          ),
                          child: const SvgIcon(AppAssets.profilePlaceholder, size: 80.0)
                        ),
                        const SizedBox(width: 28.0),
                        Expanded(
                          child: user == null ? InkWell(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Chào mừng đến với HOSREM',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.textStyle14SecondaryGrey
                                ),
                                Text(
                                  'Đăng Nhập /  Đăng Ký',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.textStyle13PrimaryBlue
                                )
                              ],
                            ),
                            onTap: () => _navigateToProfile(user),
                          ) :
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                user?.fullName ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.textStyle20PrimaryBlack
                              ),
                              Text(
                                user?.degrees?.map((Degree degree) => degree.name)?.join(',') ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.textStyle12PrimaryGrey
                              ),
                              const SizedBox(height: 12.0),
                              Text(
                                user?.phone ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.textStyle14PrimaryOrangeBold
                              ),
                            ],
                          )
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  user?.userType != 'Member' ? Container(
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
                        Text(
                          'Nâng Cấp Thành Hội Viên HOSREM',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.textStyle13PrimaryBlue
                        )
                      ],
                    )
                  ) :
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 19.5, horizontal: 28.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: SvgIcon(AppAssets.diamondIcon, size: 37.0)
                        ),
                        const SizedBox(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Hội Viên HOSREM',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.textStyle16PrimaryBlue
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Ngày hết hạn 20/10/2019',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.textStyle13PrimaryGrey
                                ),
                                const SizedBox(width: 5.0),
                                Text(
                                  'Gia hạn',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.textStyle13PrimaryBlue
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ),
                  Container(
                    height: 20.0,
                    color: AppColors.backgroundConferenceColor,
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
                  const SizedBox(height: 40.0)
                ],
              ),
            );
          }
        )
      )
    );


  }

  Future<void> _navigateToProfile(User user) async {
    if (user == null) {
      await Navigator.push<dynamic>(context, PageTransition<dynamic>(
        type: PageTransitionType.downToUp, child: Login()));
    } else {
      await Navigator.push(context, MaterialPageRoute<bool>(builder: (BuildContext context) => ProfileDetails()));
    }
    _profileBloc.dispatch(LoadProfileEvent());
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
