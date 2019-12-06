import 'package:meta/meta.dart';

/// Login conference state.
@immutable
abstract class LoginConferenceState {}

/// LoginConferenceLoading state.
class LoginConferenceLoading extends LoginConferenceState {
  @override
  String toString() => 'LoginConferenceLoading';
}

/// LoginConferenceFailure state.
class LoginConferenceFailure extends LoginConferenceState {
  LoginConferenceFailure({@required this.error});

  final String error;

  @override
  String toString() => 'LoginConferenceFailure { error: $error }';
}

/// LoginConferenceValidation state.
class LoginConferenceValidation extends LoginConferenceState {
  LoginConferenceValidation({ @required this.fields, this.loggedIn = false, this.unlocked = false,
    this.loading = false, this.errorMsg = '' });

  final bool unlocked;
  final bool loggedIn;
  final bool loading;
  final String errorMsg;
  final Map<String, bool> fields;

  @override
  String toString() => 'LoginConferenceValidation';
}

/// LoginConferenceSuccess state.
class LoginConferenceSuccess extends LoginConferenceState {
  @override
  String toString() => 'LoginConferenceSuccess';
}

