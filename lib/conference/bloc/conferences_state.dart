import 'package:hosrem_app/api/conference/conference.dart';
import 'package:meta/meta.dart';

/// Profile state.
@immutable
abstract class ConferencesState {
}

/// ConferenceInitial state.
class ConferenceInitial extends ConferencesState {
  @override
  String toString() => 'ConferenceInitial';
}

/// ConferenceLoading state.
class ConferenceLoading extends ConferencesState {
  @override
  String toString() => 'ConferenceLoading';
}

/// ConferenceFailure state.
class ConferenceFailure extends ConferencesState {
  ConferenceFailure({@required this.error});

  final String error;

  @override
  String toString() => 'ConferenceFailure { error: $error }';
}

/// LoadedConferences state.
class LoadedConferences extends ConferencesState {
  LoadedConferences({@required this.conferences});

  final List<Conference> conferences;

  @override
  String toString() => 'LoadedConferences';
}

/// LoadedConferences state.
@immutable
class RefreshConferencesCompleted extends ConferencesState {
  RefreshConferencesCompleted({@required this.conferences}) : assert(conferences != null);

  final List<Conference> conferences;

  @override
  String toString() => 'RefreshConferencesCompleted';
}
