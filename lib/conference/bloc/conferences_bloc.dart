import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
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

  List<Conference> conferences = <Conference>[];
  ConferencePagination conferencePagination;

  @override
  ConferencesState get initialState => ConferenceInitial();

  @override
  Stream<ConferencesState> mapEventToState(ConferencesEvent event) async* {
    if (event is RefreshConferencesEvent) {
      try {
        final String token = await authService.getToken();
        final Map<String, dynamic> queryParams = <String, dynamic>{
          'page': DEFAULT_PAGE,
          'size': DEFAULT_PAGE_SIZE
        };
        queryParams.addAll(event.searchCriteria);
        conferencePagination = await conferenceService.getConferences(queryParams);
        conferences = conferencePagination.items;

        yield RefreshConferencesCompleted(conferences: conferences, token: token);
        yield LoadedConferences(conferences: conferences, token: token);
      } catch (error) {
        print(error);
        yield ConferenceFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is LoadMoreConferencesEvent) {
      try {
        final String token = await authService.getToken();
        if (conferencePagination.page < conferencePagination.totalPages) {
          final Map<String, dynamic> queryParams = <String, dynamic>{
            'page': conferencePagination.page + 1,
            'size': DEFAULT_PAGE_SIZE
          };
          queryParams.addAll(event.searchCriteria);
          conferencePagination = await conferenceService.getConferences(queryParams);
          conferences.addAll(conferencePagination.items);
        }
        yield LoadedConferences(conferences: conferences, token: token);
      } catch (error) {
        print(error);
        yield ConferenceFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }
}
