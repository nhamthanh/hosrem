import 'package:meta/meta.dart';

/// Conference event.
@immutable
abstract class ConferencesEvent {
}

/// LoadConferencesEvent event.
class LoadMoreConferencesEvent extends ConferencesEvent {
  LoadMoreConferencesEvent({
    @required this.searchCriteria,
  });

  final Map<String, dynamic> searchCriteria;

  @override
  String toString() => 'LoadConferencesEvent { }';
}

/// RefreshConferencesEvent event.
class RefreshConferencesEvent extends ConferencesEvent {
  RefreshConferencesEvent({
    @required this.searchCriteria,
  });

  final Map<String, dynamic> searchCriteria;

  @override
  String toString() => 'RefreshConferencesEvent { }';
}

/// CheckRegistrationEvent event.
class CheckRegistrationEvent extends ConferencesEvent {
  CheckRegistrationEvent({
    @required this.conferenceId
  });

  final String conferenceId;

  @override
  String toString() => 'CheckRegistrationEvent { }';
}
