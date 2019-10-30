import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/membership/user_membership.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/login/bloc/login_event.dart';
import 'package:hosrem_app/login/bloc/login_state.dart';
import 'package:hosrem_app/membership/membership_service.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

/// Login bloc to handle login and logic with facebook.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({@required this.authService, @required this.membershipService})
      : assert(authService != null), assert(membershipService != null);

  final AuthService authService;
  final MembershipService membershipService;
  final Logger _logger = Logger('LoginBloc');

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        final String token = await authService.authenticate(
          email: event.email,
          password: event.password,
        );
        await authService.persistToken(token, email: event.email, password: event.password);
        final User user = await authService.loadCurrentUser();
        final UserMembership userMembership = await _getUserMembership(user);
        await authService.persistCurrentUser(user);

        if (userMembership != null) {
          await authService.persistUserMembership(userMembership);
        }
        yield LoginSuccess();
      } catch (error) {
        yield LoginFailure(error: ErrorHandler.extractErrorMessage(error));
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
