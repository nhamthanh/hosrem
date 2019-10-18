import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/api/conference/conference_pagination.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';

import '../conference_service.dart';
import 'conferences_event.dart';
import 'conferences_state.dart';

/// Conference bloc to load conferences.
class ConferencesBloc extends Bloc<ConferencesEvent, ConferencesState> {
  ConferencesBloc({@required this.conferenceService, @required this.authService}) :
      assert(conferenceService != null), assert(authService != null);

  static const int DEFAULT_PAGE = 0;
  static const int DEFAULT_PAGE_SIZE = 10;

  final ConferenceService conferenceService;
  final AuthService authService;

  final Map<String, bool> _registeredConferences = <String, bool>{};

  List<Conference> _conferences = <Conference>[];
  ConferencePagination _conferencePagination;

  @override
  ConferencesState get initialState => ConferenceInitial();

  @override
  Stream<ConferencesState> mapEventToState(ConferencesEvent event) async* {
    if (event is RefreshConferencesEvent) {
      try {
        final Map<String, dynamic> queryParams = <String, dynamic>{
          'page': DEFAULT_PAGE,
          'size': DEFAULT_PAGE_SIZE
        };
        queryParams.addAll(event.searchCriteria);
        _conferencePagination = await conferenceService.getConferences(queryParams);
        _conferences = _conferencePagination.items;

        _dispatchCheckRegistrationEvents(_conferences);

        yield RefreshConferencesCompleted();
        yield LoadedConferences(conferences: _conferences, registeredConferences: _registeredConferences);
      } catch (error) {
        print(error);
        yield ConferenceFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is LoadMoreConferencesEvent) {
      try {
        if (_conferencePagination.page < _conferencePagination.totalPages) {
          final Map<String, dynamic> queryParams = <String, dynamic>{
            'page': _conferencePagination.page + 1,
            'size': DEFAULT_PAGE_SIZE
          };
          queryParams.addAll(event.searchCriteria);

          _conferencePagination = await conferenceService.getConferences(queryParams);
          _conferences.addAll(_conferencePagination.items);

          _dispatchCheckRegistrationEvents(_conferencePagination.items);
        }
        yield LoadedConferences(conferences: _conferences, registeredConferences: _registeredConferences);
      } catch (error) {
        print(error);
        yield ConferenceFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is CheckRegistrationEvent) {
      try {
        if (!_registeredConferences.containsKey(event.conferenceId)) {
          final User user = await authService.currentUser();
          final bool registeredConference = user == null ? false : await conferenceService.checkIfUserRegisterConference(
            event.conferenceId, user?.id);
          _registeredConferences[event.conferenceId] = registeredConference;
          yield LoadedConferences(conferences: _conferences, registeredConferences: _registeredConferences);
        }

      } catch (error) {
        print(error);
        yield ConferenceFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }

  void _dispatchCheckRegistrationEvents(List<Conference> conferences) {
    for (final Conference conference in conferences) {
      dispatch(CheckRegistrationEvent(conferenceId: conference.id));
    }
  }
}
