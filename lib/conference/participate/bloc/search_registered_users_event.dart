import 'package:meta/meta.dart';

/// Search registered users event.
@immutable
abstract class SearchRegisteredUsersEvent {
}

/// LoadSearchRegisteredUsersEvent event.
class LoadMoreSearchRegisteredUsersEvent extends SearchRegisteredUsersEvent {
  LoadMoreSearchRegisteredUsersEvent({
    @required this.conferenceId, @required this.searchCriteria,
  });

  final String conferenceId;
  final Map<String, dynamic> searchCriteria;

  @override
  String toString() => 'LoadSearchRegisteredUsersEvent { }';
}

/// RefreshSearchRegisteredUsersEvent event.
class RefreshSearchRegisteredUsersEvent extends SearchRegisteredUsersEvent {
  RefreshSearchRegisteredUsersEvent({
    @required this.conferenceId, @required this.searchCriteria,
  });

  final String conferenceId;
  final Map<String, dynamic> searchCriteria;

  @override
  String toString() => 'RefreshSearchRegisteredUsersEvent { }';
}
