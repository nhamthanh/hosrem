import 'package:hosrem_app/api/conference/conference_fee.dart';
import 'package:hosrem_app/api/conference/conference_fees.dart';
import 'package:meta/meta.dart';

/// Conference fees state.
@immutable
abstract class ConferenceFeesState {
}

/// ConferenceFeesLoading state.
class ConferenceFeesLoading extends ConferenceFeesState {
  @override
  String toString() => 'ConferenceFeesLoading';
}

/// DocumentsFailure state.
class ConferenceFeesFailure extends ConferenceFeesState {
  ConferenceFeesFailure({@required this.error});

  final String error;

  @override
  String toString() => 'ConferenceFeesFailure { error: $error }';
}

/// LoadedConferenceFees state.
class LoadedConferenceFees extends ConferenceFeesState {
  LoadedConferenceFees(this.conferenceFees, this.selectedConferenceFee, { this.allowRegistration = false });

  final ConferenceFees conferenceFees;
  final List<ConferenceFee> selectedConferenceFee;
  final bool allowRegistration;

  @override
  String toString() => 'LoadedConferenceFees';
}

