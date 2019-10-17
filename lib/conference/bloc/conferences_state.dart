import 'package:hosrem_app/api/conference/conference.dart';
import 'package:meta/meta.dart';

/// Conferenes  state.
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
  LoadedConferences({@required this.conferences, @required this.token, @required this.registeredConferences}) :
      assert(conferences != null), assert(token != null), assert(registeredConferences != null);

  final List<Conference> conferences;
  final Map<String, bool> registeredConferences;
  final String token;

  @override
  String toString() => 'LoadedConferences';
}

/// RefreshConferencesCompleted state.
@immutable
class RefreshConferencesCompleted extends ConferencesState {
  @override
  String toString() => 'RefreshConferencesCompleted';
}
