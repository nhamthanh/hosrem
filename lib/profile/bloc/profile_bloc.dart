import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/membership/user_membership.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/membership/membership_service.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import 'profile_event.dart';
import 'profile_state.dart';

/// Profile bloc load and save user profile.
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    @required this.authService,
    @required this.membershipService
  })  : assert(authService != null);

  final AuthService authService;
  final MembershipService membershipService;
  final Logger _logger = Logger('ProfileBloc');

  @override
  ProfileState get initialState => ProfileInitial();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is LoadProfileEvent) {
      yield ProfileLoading();

      try {
        final User user = await authService.currentUser();
        final UserMembership userMembership = await authService.currentUserMembership();
        if (user == null) {

        }
        yield ProfileSuccess(user: user, userMembership: userMembership);
      } catch (error) {
        yield ProfileFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is ReloadProfileEvent) {
      yield ProfileLoading();

      try {
        final User user = await authService.loadCurrentUser();
        await authService.persistCurrentUser(user);

        final UserMembership userMembership = await _getUserMembership(user);
        if (userMembership != null) {
          await authService.persistUserMembership(userMembership);
        }
        yield ProfileSuccess(user: user, userMembership: userMembership);
      } catch (error) {
        yield ProfileFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

  }

  Future<UserMembership> _getUserMembership(User user) async {
    try {
      return await membershipService.getMembershipStatusOfUser(user?.id);
    } catch (error) {
      _logger.fine(error);
    }

    return null;
  }
}
