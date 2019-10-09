import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:meta/meta.dart';

import 'profile_event.dart';
import 'profile_state.dart';

/// Profile bloc load and save user profile.
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    @required this.authService
  })  : assert(authService != null);

  final AuthService authService;

  @override
  ProfileState get initialState => ProfileInitial();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is LoadProfileEvent) {
      yield ProfileLoading();

      try {
        final User user = await authService.currentUser();
        yield ProfileSuccess(user: user);
      } catch (error) {
        yield ProfileFailure(error: error.toString());
      }
    }

    if (event is SaveProfileEvent) {
      yield ProfileLoading();

      try {
        await authService.updateProfile(event.user);
        yield UpdateProfileSuccess();
      } catch (error) {
        yield ProfileFailure(error: error.toString());
      }
    }
  }
}
