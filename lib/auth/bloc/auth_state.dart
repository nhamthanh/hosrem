import 'package:hosrem_app/api/auth/user.dart';
import 'package:meta/meta.dart';

/// Auth state.
@immutable
abstract class AuthState {}

/// LoginInitial state.
class LoginInitial extends AuthState {
  @override
  String toString() => 'LoginInitial';
}

/// LoginValidationState state.
class LoginValidationState extends AuthState {
  LoginValidationState({ this.validEmail = false, this.validPassword = false });

  final bool validEmail;
  final bool validPassword;

  @override
  String toString() => 'LoginValidationState { validEmail = $validEmail, validPassword = $validPassword } ';
}

/// LoginLoading state.
class LoginLoading extends AuthState {
  @override
  String toString() => 'LoginLoading';
}

/// LoginFailure state.
class LoginFailure extends AuthState {
  LoginFailure({@required this.error});

  final String error;

  @override
  String toString() => 'LoginFailure { error: $error }';
}

/// LoginSuccess state.
class LoginSuccess extends AuthState {
  LoginSuccess(this.user);

  final User user;

  @override
  String toString() => 'LoginSuccess';
}

/// RegistrationValidationState state.
@immutable
class RegistrationValidationState extends AuthState {
  RegistrationValidationState({
    this.validPhone = false,
    this.validFullName = false,
    this.validEmail = false,
    this.validPassword = false,
    this.checked = false
  });

  final bool validPhone;
  final bool validFullName;
  final bool validEmail;
  final bool validPassword;
  final bool checked;

  @override
  String toString() => 'RegistrationValidationState { validEmail = $validEmail, validPassword = $validPassword } ';
}

/// RegistrationSuccess state.
class RegistrationSuccess extends AuthState {
  @override
  String toString() => 'RegistrationSuccess';
}

/// RegistrationCleanState state.
class RegistrationCleanState extends AuthState {
  @override
  String toString() => 'RegistrationCleanState';
}
