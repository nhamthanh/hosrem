import 'package:hosrem_app/api/conference/public_registration.dart';
import 'package:meta/meta.dart';

/// Search registered users state.
@immutable
abstract class SearchRegisteredUsersState {
}

/// SearchRegisteredUsersInitial state.
class SearchRegisteredUsersInitial extends SearchRegisteredUsersState {
  @override
  String toString() => 'SearchRegisteredUsersInitial';
}

/// SearchRegisteredUsersLoading state.
class SearchRegisteredUsersLoading extends SearchRegisteredUsersState {
  @override
  String toString() => 'SearchRegisteredUsersLoading';
}

/// SearchRegisteredUsersFailure state.
class SearchRegisteredUsersFailure extends SearchRegisteredUsersState {
  SearchRegisteredUsersFailure({@required this.error});

  final String error;

  @override
  String toString() => 'SearchRegisteredUsersFailure { error: $error }';
}

/// LoadedSearchRegisteredUsers state.
class LoadedSearchRegisteredUsers extends SearchRegisteredUsersState {
  LoadedSearchRegisteredUsers({@required this.searchRegisteredUsers}) :
      assert(searchRegisteredUsers != null);

  final List<PublicRegistration> searchRegisteredUsers;

  @override
  String toString() => 'LoadedSearchRegisteredUsers';
}

/// RefreshSearchRegisteredUsersCompleted state.
@immutable
class RefreshSearchRegisteredUsersCompleted extends SearchRegisteredUsersState {
  @override
  String toString() => 'RefreshSearchRegisteredUsersCompleted';
}
