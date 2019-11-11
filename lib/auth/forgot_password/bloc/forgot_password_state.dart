import 'package:meta/meta.dart';

/// Forgot password state.
@immutable
abstract class ForgotPasswordState {}

/// ForgotPasswordStateInitial state.
class ForgotPasswordStateInitial extends ForgotPasswordState {
  @override
  String toString() => 'ForgotPasswordInitial';
}

/// VerifyEmail state.
class VerifyEmailState extends ForgotPasswordState {
  VerifyEmailState({@required this.email,this.validEmail = false});
  final String email;
  final bool validEmail;
  @override
  String toString() => 'VerifyEmailState {email: $email}';
}

/// VerifyEmail Success state.
class VerifyEmailResultState extends ForgotPasswordState {
  VerifyEmailResultState({@required this.email, this.result = false, this.message});
  final String email;
  final bool result;
  final String message;
  @override
  String toString() => 'VerifyEmailResultState {email: $email, result: $result, message: $message}';
}

/// VerifyCode state.
class VerifyCodeState extends ForgotPasswordState {
  VerifyCodeState({@required this.code});
  final String code;
  @override
  String toString() => 'VerifyCodeState {code: $code}';
}

/// VerifyEmail Result state.
class VerifyCodeResultState extends ForgotPasswordState {
  VerifyCodeResultState({@required this.code, this.result = false});
  final String code;
  final bool result;
  @override
  String toString() => 'VerifyCodeResultState {code: $code, result: $result}';
}

// ForgotPasswordSuccess state
class ForgotPasswordSuccess extends ForgotPasswordState {
  @override
  String toString() => 'ForgotPasswordSuccess';
}

/// ChangePasswordState state.
class ChangePasswordState extends ForgotPasswordState {
  ChangePasswordState({this.code, this.password, this.email});
  final String code;
  final String password;
  final String email;
  @override
  String toString() => 'ChangePasswordState {id: $email, code: $code}';
}

/// ForgetPasswordLoading state.
class ForgetPasswordLoading extends ForgotPasswordState {
  @override
  String toString() => 'ForgetPasswordLoading';
}

/// ForgetPasswordFailure state.
class ForgetPasswordFailure extends ForgotPasswordState {
  ForgetPasswordFailure({@required this.error});

  final String error;

  @override
  String toString() => 'ForgetPasswordFailure { error: $error }';
}
