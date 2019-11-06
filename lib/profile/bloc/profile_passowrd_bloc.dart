import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/profile/bloc/profile_password_event.dart';
import 'package:hosrem_app/profile/bloc/profile_password_state.dart';
import 'package:meta/meta.dart';


/// Profile Password Bloc.
class ProfilePasswordBloc extends Bloc<ProfilePasswordEvent, ProfilePasswordState> {
  ProfilePasswordBloc({@required this.authService}) : assert(authService != null);

  final AuthService authService;

  @override
  ProfilePasswordState get initialState => ProfilePasswordStateInitial();

  @override
  Stream<ProfilePasswordState> mapEventToState(ProfilePasswordEvent event) async* {
    if (event is ChangePasswordButtonPressed) {
      final String password = await authService.getUserPassword();
      /// 1. Validate password
      if (event.userPassword.oldPassword != password) {
        yield ProfilePasswordValidationState(
          checked: false
        );
        return;
      }
      /// 2. Submit change password form.
      yield ProfilePasswordLoading();

      try {
        await authService.updateUserPassword(event.id, event.userPassword);
        await authService.clearUser();
        yield ProfilePasswordSuccess();
      } catch (error) {
        yield ProfilePasswordFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }
}
