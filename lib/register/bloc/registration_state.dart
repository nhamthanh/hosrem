import 'package:meta/meta.dart';

/// Registration state.
@immutable
abstract class RegistrationState {}

/// RegistrationInitial state.
class RegistrationInitial extends RegistrationState {
  @override
  String toString() => 'RegisterInitial';
}

/// RegistrationValidationState state.
@immutable
class RegistrationValidationState extends RegistrationState {
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

/// RegistrationLoading state.
class RegistrationLoading extends RegistrationState {
  @override
  String toString() => 'RegistrationLoading';
}

/// RegistrationSuccess state.
class RegistrationSuccess extends RegistrationState {
  @override
  String toString() => 'RegistrationSuccess';
}

/// RegistrationFailure state.
class RegistrationFailure extends RegistrationState {
  RegistrationFailure({@required this.error});

  final String error;

  @override
  String toString() => 'RegistrationFailure { error: $error }';
}

/// RegistrationCleanState state.
class RegistrationCleanState extends RegistrationState {
  @override
  String toString() => 'RegistrationCleanState';
}
