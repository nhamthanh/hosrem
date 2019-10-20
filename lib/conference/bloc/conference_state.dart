import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/api/document/document.dart';
import 'package:meta/meta.dart';

/// Conference state.
@immutable
abstract class ConferenceState {
}

/// ConferenceInitial state.
class ConferenceInitial extends ConferenceState {
  @override
  String toString() => 'ConferenceInitial';
}

/// ConferenceLoading state.
class ConferenceLoading extends ConferenceState {
  @override
  String toString() => 'ConferenceLoading';
}

/// ConferenceFailure state.
class ConferenceFailure extends ConferenceState {
  ConferenceFailure({@required this.error});

  final String error;

  @override
  String toString() => 'ConferenceFailure { error: $error }';
}

/// LoadedDocumentsState state.
class LoadedConferenceState extends ConferenceState {
  LoadedConferenceState({@required this.documents, @required this.conference});

  final Conference conference;
  final List<Document> documents;

  @override
  String toString() => 'LoadedConferenceState';
}

