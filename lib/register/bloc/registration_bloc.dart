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
      yield RegistrationLoading();

      try {
        await authService.signUp(event.toUser());
        yield RegistrationSuccess();
      } catch (error) {
        yield RegistrationFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is CleanRegistrationEvent) {
      yield RegistrationCleanState();
    }
  }
}
