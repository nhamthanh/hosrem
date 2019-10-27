import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/conference/conference_fee.dart';

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

/// ConferenceRegistrationDataSuccess state.
class ConferenceRegistrationDataSuccess extends ConferenceRegistrationState {
  ConferenceRegistrationDataSuccess(this.premiumMembership, this.selectedConferenceFee);

  final bool premiumMembership;
  final ConferenceFee selectedConferenceFee;

  @override
  String toString() => 'ConferenceRegistrationDataSuccess { premiumMembership: $premiumMembership }';
}
