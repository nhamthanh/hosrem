import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/api/auth/forgot_password.dart';
import 'package:hosrem_app/api/auth/user_password.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/auth/forgot_password/bloc/forgot_password_event.dart';
import 'package:hosrem_app/auth/forgot_password/bloc/forgot_password_state.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:meta/meta.dart';


/// Forgot Password Bloc.
class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({@required this.authService}) : assert(authService != null);

  final AuthService authService;

  @override
  ForgotPasswordState get initialState => ForgotPasswordStateInitial();

  @override
  Stream<ForgotPasswordState> mapEventToState(ForgotPasswordEvent event) async* {
    if (event is VerifyEmailEvent) {
      /// Verify email and generate verify code
      try {
        await authService.forgotPassword(ForgotPassword(event.email, null, null));
        yield VerifyEmailResultState(email: event.email, result: true);
      } catch (error) {
        yield VerifyEmailResultState(email: event.email, result: false, message: ErrorHandler.extractErrorMessage(error));
      }
    }
    if (event is VerifyCodeEvent) {
      /// Validate Code
      try {
        final bool verifyCode = await authService.verifyResetPasswordCode(event.code);
        if (verifyCode) {
          yield VerifyCodeResultState(code: event.code, result: verifyCode);
        } else {
          yield VerifyCodeResultState(code: event.code, result: verifyCode);
          return;
        } 
      } catch (error) {
        yield ForgetPasswordFailure(error: ErrorHandler.extractErrorMessage(error));
        return;
      }
    }
    if (event is ChangePasswordEvent) {
      /// Change password
      try {
        await authService.resetUserPassword(UserPassword(null, event.password, null, null, event.code));
        yield ForgotPasswordSuccess();
      } catch (error) {
        yield ForgetPasswordFailure(error: ErrorHandler.extractErrorMessage(error));
        return;
      }
    }
  }
}
