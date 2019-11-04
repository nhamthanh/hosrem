import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/membership/user_membership.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/membership/membership_service.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import 'auth_event.dart';
import 'auth_state.dart';

/// Auth bloc to handle login, login with facebook and register a new account.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({@required this.authService, @required this.membershipService})
      : assert(authService != null), assert(membershipService != null);

  final AuthService authService;
  final MembershipService membershipService;
  final Logger _logger = Logger('LoginBloc');

  @override
  AuthState get initialState => LoginInitial();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginButtonPressed) {
      /// 1. Validate login form.
      if (event.email.isEmpty || event.password.isEmpty) {
        yield LoginValidationState(validEmail: event.email.isNotEmpty, validPassword: event.password.isNotEmpty);
        return;
      }

      /// 2. Submit login form.
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

    if (event is RegisterButtonPressed) {
      /// 1. Validate login form.
      if (event.email.isEmpty || event.password.isEmpty || event.fullName.isEmpty || event.phone.isEmpty || !event.checked) {
        yield RegistrationValidationState(
          validFullName: event.fullName.isNotEmpty,
          validPhone: event.phone.isNotEmpty,
          validEmail: event.email.isNotEmpty,
          validPassword: event.password.isNotEmpty,
          checked: event.checked
        );
        return;
      }

      /// 2. Submit registration form.
      yield LoginLoading();

      try {
        await authService.signUp(event.toUser());
        yield RegistrationSuccess();
      } catch (error) {
        yield LoginFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is CleanRegistrationEvent) {
      yield RegistrationCleanState();
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
