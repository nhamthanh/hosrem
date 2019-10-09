import 'package:hosrem_app/api/conference/conference_resource.dart';
import 'package:meta/meta.dart';

/// Profile state.
@immutable
abstract class ConferenceResourcesState {
}

/// ConferenceResourcesLoading state.
class ConferenceResourcesLoading extends ConferenceResourcesState {
  @override
  String toString() => 'ConferenceResourcesLoading';
}

/// ConferenceResourcesFailure state.
class ConferenceResourcesFailure extends ConferenceResourcesState {
  ConferenceResourcesFailure({@required this.error});

  final String error;

  @override
  String toString() => 'ConferenceResourcesFailure { error: $error }';
}

/// LoadedConferenceResources state.
class LoadedConferenceResources extends ConferenceResourcesState {
  LoadedConferenceResources({@required this.conferenceResources});

  final List<ConferenceResource> conferenceResources;

  @override
  String toString() => 'LoadedConferences';
}

/// RefreshConferenceResourcesCompleted state.
@immutable
class RefreshConferenceResourcesCompleted extends ConferenceResourcesState {
  RefreshConferenceResourcesCompleted({@required this.conferenceResources}) : assert(conferenceResources != null);

  final List<ConferenceResource> conferenceResources;

  @override
  String toString() => 'RefreshConferenceResourcesCompleted';
}
