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
  LoadedConferenceFees({@required this.conferenceFees});

  final ConferenceFees conferenceFees;

  @override
  String toString() => 'LoadedConferenceFees';
}

