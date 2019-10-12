import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/register/bloc/registration_event.dart';
import 'package:meta/meta.dart';

import 'package:hosrem_app/register/bloc/registration_state.dart';

/// Registration Bloc.
class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc({@required this.authService}) : assert(authService != null);

  final AuthService authService;

  @override
  RegistrationState get initialState => RegistrationInitial();

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is RegisterButtonPressed) {
      yield RegistrationLoading();

      try {
        await authService.signUp(event.toUser());
        yield RegistrationSuccess();
      } catch (error) {
        yield RegistrationFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }
}
