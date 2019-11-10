import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hosrem_app/auth/auth_service.dart';

import 'home_event.dart';
import 'home_state.dart';

/// Home bloc to handle switching bottom navigation bar.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.authService);

  final AuthService authService;

  @override
  HomeState get initialState => const ShowNews();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    switch (event) {
      case HomeEvent.Events:
        yield const ShowEvents();
        break;

      case HomeEvent.Notifications:
        yield ShowNotifications(hasToken: await authService.hasToken());
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
