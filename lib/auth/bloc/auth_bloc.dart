import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/common/string_utils.dart';
import 'package:hosrem_app/membership/membership_service.dart';
import 'package:hosrem_app/notification/notification_service.dart';
import 'package:meta/meta.dart';

import 'auth_event.dart';
import 'auth_state.dart';

/// Auth bloc to handle login, login with facebook and register a new account.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({ @required this.authService, @required this.membershipService, this.notificationService })
      : assert(authService != null), assert(membershipService != null);

  final AuthService authService;
  final MembershipService membershipService;
  final NotificationService notificationService;

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
        await authService.clearUser();
        await authService.persistToken(token, email: event.email, password: event.password);
        final User user = await authService.loadCurrentUser();
        await authService.persistCurrentUser(user);
        await _registerPushNotification();
        yield LoginSuccess(user);
      } catch (error) {
        yield LoginFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is LoginFacebookButtonPressed) {
      try {
        final String token = await authService.loginWithFacebook();
        if (token == null) {
          return;
        }
        yield LoginLoading();
        await authService.persistToken(token);
        final User user = await authService.loadCurrentUser();
        await authService.persistCurrentUser(user);
        await _registerPushNotification();
        yield LoginSuccess(user);
      } catch (error) {
        yield LoginFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }


    if (event is RegisterButtonPressed) {
      /// 1. Validate login form.
      if (event.email.isEmpty || event.password.isEmpty || event.fullName.isEmpty || event.phone.isEmpty || !event.checked || !StringUtils.validateEmail(event.email)) {
        yield RegistrationValidationState(
          validFullName: event.fullName.isNotEmpty,
          validPhone: event.phone.isNotEmpty,
          validEmail: event.email.isNotEmpty && StringUtils.validateEmail(event.email),
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

  Future<void> _registerPushNotification() async {
    final String fcmToken = await notificationService.getFcmToken();
    if (fcmToken != null) {
      await notificationService.registerToken(fcmToken);
    }
  }
}
