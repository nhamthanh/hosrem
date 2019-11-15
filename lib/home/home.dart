import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/article/articles.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/auth/login_registration.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/conference/conferences.dart';
import 'package:hosrem_app/notification/notifications.dart';
import 'package:hosrem_app/profile/profile.dart';
import 'package:hosrem_app/widget/svg/svg_icon.dart';
import 'package:page_transition/page_transition.dart';

import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';

/// Home page.
@immutable
class Home extends StatefulWidget {
  const Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends BaseState<Home> {

  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();

    _homeBloc = HomeBloc(AuthService(apiProvider));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      builder: (BuildContext context) => _homeBloc,
      child: BlocListener<HomeBloc, HomeState>(
        listener: (BuildContext context, HomeState state) async {
          if (state is ShowNotifications) {
            if (!state.hasToken) {
              final bool result = await pushWidgetWithTransitionResult(LoginRegistration(), PageTransitionType.downToUp);
              if (result == null || !result) {
                _homeBloc.dispatch(HomeEvent.News);
              } else {
                _homeBloc.dispatch(HomeEvent.Notifications);
              }
              onResumeWidget();
            }
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          bloc: _homeBloc,
          builder: (BuildContext context, HomeState state) {
            return Scaffold(
              body: _buildHomeBody(state),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: state.itemIndex,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: const SvgIcon(AppAssets.homeNormalIcon),
                    activeIcon: const SvgIcon(AppAssets.homeSelectedIcon),
                    title: Text(
                      AppLocalizations.of(context).tr('home.home'),
                      style: TextStyles.textStyleBold
                    )
                  ),
                  BottomNavigationBarItem(
                    icon: const SvgIcon(AppAssets.eventNormalIcon),
                    activeIcon: const SvgIcon(AppAssets.eventSelectedIcon),
                    title: Text(
                      AppLocalizations.of(context).tr('home.events'),
                      style: TextStyles.textStyleBold
                    )
                  ),
                  BottomNavigationBarItem(
                    icon: const SvgIcon(AppAssets.notificationNormalIcon),
                    activeIcon: const SvgIcon(AppAssets.notificationSelectedIcon),
                    title: Text(
                      AppLocalizations.of(context).tr('home.notifications'),
                      style: TextStyles.textStyleBold
                    )
                  ),
                  BottomNavigationBarItem(
                    icon: const SvgIcon(AppAssets.profileNormalIcon),
                    activeIcon: const SvgIcon(AppAssets.profileSelectedIcon),
                    title: Text(
                      AppLocalizations.of(context).tr('home.profile'),
                      style: TextStyles.textStyleBold
                    )
                  ),
                ],
                onTap: _handleBottomBarTap,
              ),
            );
          }
        )
      )
    );
  }

  void _handleBottomBarTap(int index) {
    switch (index) {
      case 0:
        _homeBloc.dispatch(HomeEvent.News);
        break;

      case 1:
        _homeBloc.dispatch(HomeEvent.Events);
        break;

      case 2:
        _homeBloc.dispatch(HomeEvent.Notifications);
        break;

      case 3:
        _homeBloc.dispatch(HomeEvent.Profile);
        break;

      default:
        _homeBloc.dispatch(HomeEvent.News);
        break;
    }
  }

  Widget _buildHomeBody(HomeState state) {
    if (state is ShowEvents) {
      return Center(
        child: const Conferences(),
      );
    }

    if (state is ShowNotifications) {
      if (state.hasToken) {
        return Notifications();
      }
      return Container();
    }

    if (state is ShowProfile) {
      return Center(
        child: Profile(),
      );
    }

    return const Articles();
  }
}
