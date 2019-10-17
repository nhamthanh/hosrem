import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/conference/conferences.dart';
import 'package:hosrem_app/notification/notifications.dart';
import 'package:hosrem_app/profile/profile.dart';
import 'package:hosrem_app/widget/svg/svg_icon.dart';

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

class _HomeState extends State<Home> {

  final HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();

    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true));

    _firebaseMessaging.onIosSettingsRegistered
      .listen((IosNotificationSettings settings) {
      print('Settings registered: $settings');
    });
    _firebaseMessaging.getToken().then((String token) {
      print('token: $token');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: _homeBloc,
      builder: (BuildContext context, HomeState state) {
        return Scaffold(
          body: _buildHomeBody(state),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: state.itemIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const SvgIcon('assets/images/home_normal.svg'),
                activeIcon: const SvgIcon('assets/images/home_selected.svg'),
                title: Text(
                  AppLocalizations.of(context).tr('home.home'),
                  style: TextStyles.textStyleBold
                )
              ),
              BottomNavigationBarItem(
                icon: const SvgIcon('assets/images/event_normal.svg'),
                activeIcon: const SvgIcon('assets/images/event_selected.svg'),
                title: Text(
                  AppLocalizations.of(context).tr('home.events'),
                  style: TextStyles.textStyleBold
                )
              ),
              BottomNavigationBarItem(
                icon: const SvgIcon('assets/images/notification_normal.svg'),
                activeIcon: const SvgIcon('assets/images/notification_selected.svg'),
                title: Text(
                  AppLocalizations.of(context).tr('home.notifications'),
                  style: TextStyles.textStyleBold
                )
              ),
              BottomNavigationBarItem(
                icon: const SvgIcon('assets/images/profile_normal.svg'),
                activeIcon: const SvgIcon('assets/images/profile_selected.svg'),
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
      return Notifications();
    }

    if (state is ShowProfile) {
      return Center(
        child: Profile(),
      );
    }

    return Center(
      child: Text(AppLocalizations.of(context).tr('home.under_construction')),
    );
  }
}
