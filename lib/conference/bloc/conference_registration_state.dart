import 'package:flutter/widgets.dart';

/// Conference registration state.
@immutable
abstract class ConferenceRegistrationState {
}

/// ConferenceRegistrationLoading state.
class ConferenceRegistrationLoading extends ConferenceRegistrationState {
  @override
  String toString() => 'ConferenceRegistrationLoading';
}

/// ConferenceRegistrationFailure state.
class ConferenceRegistrationFailure extends ConferenceRegistrationState {
  ConferenceRegistrationFailure({@required this.error});

  final String error;

  @override
  String toString() => 'ConferenceRegistrationFailure { error: $error }';
}
