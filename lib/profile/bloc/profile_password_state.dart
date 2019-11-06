import 'package:meta/meta.dart';

/// Registration state.
@immutable
abstract class ProfilePasswordState {}

/// ProfilePasswordStateInitial state.
class ProfilePasswordStateInitial extends ProfilePasswordState {
  @override
  String toString() => 'RegisterInitial';
}

/// ProfilePasswordValidationState state.
@immutable
class ProfilePasswordValidationState extends ProfilePasswordState {
  ProfilePasswordValidationState({
    this.checked = false
  });

  final bool checked;

  @override
  String toString() => 'ProfilePasswordValidationState {} ';
}

/// ProfilePasswordLoading state.
class ProfilePasswordLoading extends ProfilePasswordState {
  @override
  String toString() => 'ProfilePasswordLoading';
}

/// ProfilePasswordSuccess state.
class ProfilePasswordSuccess extends ProfilePasswordState {
  @override
  String toString() => 'ProfilePasswordSuccess';
}

/// ProfilePasswordFailure state.
class ProfilePasswordFailure extends ProfilePasswordState {
  ProfilePasswordFailure({@required this.error});

  final String error;

  @override
  String toString() => 'ProfilePasswordFailure { error: $error }';
}

/// RegistrationCleanState state.
class RegistrationCleanState extends ProfilePasswordState {
  @override
  String toString() => 'RegistrationCleanState';
}
