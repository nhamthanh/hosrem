import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/conference/conferences.dart';
import 'package:hosrem_app/profile/profile.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: _homeBloc,
      builder: (BuildContext context, HomeState state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.title),
            centerTitle: true
          ),
          body: _buildHomeBody(state),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: state.itemIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(AppLocalizations.of(context).tr('home.home')),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event_note),
                title: Text(AppLocalizations.of(context).tr('home.events')),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                title: Text(AppLocalizations.of(context).tr('home.notifications')),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text(AppLocalizations.of(context).tr('home.profile')),
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
        child: Conferences(),
      );
    }

    if (state is ShowNotifications) {
      return Center(
        child: const Text('Notifications'),
      );
    }

    if (state is ShowProfile) {
      return Center(
        child: Profile(),
      );
    }

    return Center(
      child: const Text('News'),
    );
  }
}
