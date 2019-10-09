import 'dart:async';

import 'package:bloc/bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

/// Home bloc to handle switching bottom navigation bar.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => const ShowNews();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    switch (event) {
      case HomeEvent.Events:
        yield const ShowEvents();
        break;

      case HomeEvent.Notifications:
        yield const ShowNotifications();
        break;

      case HomeEvent.Profile:
        yield const ShowProfile();
        break;

      default:
        yield const ShowNews();
        break;
    }
  }
}
