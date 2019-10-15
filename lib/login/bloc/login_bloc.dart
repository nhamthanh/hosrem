import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/login/bloc/login_event.dart';
import 'package:hosrem_app/login/bloc/login_state.dart';
import 'package:meta/meta.dart';

/// Login bloc to handle login and logic with facebook.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({@required this.authService}) : assert(authService != null);

  final AuthService authService;

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
        await authService.persistCurrentUser(user);
        yield LoginSuccess();
      } catch (error) {
        yield LoginFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is LoginFacebookButtonPressed) {
      yield LoginLoading();

      try {
        final String token = await authService.loginWithFacebook();
        await authService.persistToken(token);
        final User user = await authService.loadCurrentUser();
        await authService.persistCurrentUser(user);
        yield LoginSuccess();
      } catch (error) {
        yield LoginFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }
}
