import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/conference/public_registration.dart';
import 'package:hosrem_app/api/conference/public_registration_pagination.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/conference/participate/bloc/search_registered_users_event.dart';
import 'package:hosrem_app/conference/participate/bloc/search_registered_users_state.dart';
import 'package:hosrem_app/conference/participate/search_registered_users_service.dart';


/// Search Registered User bloc to load SearchRegisteredUsers.
class SearchRegisteredUsersBloc extends Bloc<SearchRegisteredUsersEvent, SearchRegisteredUsersState> {
  SearchRegisteredUsersBloc({@required this.searchRegisteredUsersService, @required this.authService}) :
      assert(searchRegisteredUsersService != null), assert(authService != null);

  static const int DEFAULT_PAGE = 0;
  static const int MAX_PAGE_SIZE = 100;

  final SearchRegisteredUsersService searchRegisteredUsersService;
  final AuthService authService;

  List<PublicRegistration> _searchRegisteredUsers = <PublicRegistration>[];
  PublicRegistrationPagination _publicRegistration;

  @override
  SearchRegisteredUsersState get initialState => SearchRegisteredUsersInitial();

  /// Search registered users by query parameters [queryParams].
  Future<PublicRegistrationPagination> querySearchRegisteredUsers(String conferenceId, Map<String, dynamic> queryParams) async {
    return searchRegisteredUsersService.getSearchRegisteredUsers(conferenceId, queryParams);
  }

  @override
  Stream<SearchRegisteredUsersState> mapEventToState(SearchRegisteredUsersEvent event) async* {
    if (event is RefreshSearchRegisteredUsersEvent) {
      if (event.searchCriteria.isEmpty || event.searchCriteria.values.first.toString().isEmpty) {
        yield LoadedSearchRegisteredUsers(searchRegisteredUsers: const <PublicRegistration>[]);
        return;
      }
      try {
        final Map<String, dynamic> queryParams = <String, dynamic>{
          'page': DEFAULT_PAGE,
          'size': MAX_PAGE_SIZE
        };
        queryParams.addAll(event.searchCriteria);
        _publicRegistration = await querySearchRegisteredUsers(event.conferenceId ,queryParams);
        _searchRegisteredUsers = _publicRegistration.items;

        yield RefreshSearchRegisteredUsersCompleted();
        yield LoadedSearchRegisteredUsers(searchRegisteredUsers: _searchRegisteredUsers);
      } catch (error) {
        print(error);
        yield SearchRegisteredUsersFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is LoadMoreSearchRegisteredUsersEvent) {
      try {
        if (_publicRegistration.page < _publicRegistration.totalPages) {
          final Map<String, dynamic> queryParams = <String, dynamic>{
            'page': _publicRegistration.page + 1,
            'size': MAX_PAGE_SIZE
          };
          queryParams.addAll(event.searchCriteria);

          _publicRegistration = await querySearchRegisteredUsers(event.conferenceId, queryParams);
          _searchRegisteredUsers.addAll(_publicRegistration.items);

        }
        yield LoadedSearchRegisteredUsers(searchRegisteredUsers: _searchRegisteredUsers);
      } catch (error) {
        print(error);
        yield SearchRegisteredUsersFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }
}
