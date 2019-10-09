import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/api/conference/conference_pagination.dart';

import '../conference_service.dart';
import 'conferences_event.dart';
import 'conferences_state.dart';

/// Conference bloc to load conferences.
class ConferencesBloc extends Bloc<ConferencesEvent, ConferencesState> {
  ConferencesBloc({@required this.conferenceService}) : assert(conferenceService != null);

  static const int DEFAULT_PAGE = 0;
  static const int DEFAULT_PAGE_SIZE = 10;

  final ConferenceService conferenceService;

  List<Conference> conferences = <Conference>[];
  ConferencePagination conferencePagination;

  @override
  ConferencesState get initialState => ConferenceInitial();

  @override
  Stream<ConferencesState> mapEventToState(ConferencesEvent event) async* {
    if (event is RefreshConferencesEvent) {
      try {
        conferencePagination = await conferenceService.getConferences(
          DEFAULT_PAGE, DEFAULT_PAGE_SIZE);
        conferences = conferencePagination.items;
        yield RefreshConferencesCompleted(conferences: conferences);
        yield LoadedConferences(conferences: conferences);
      } catch (error) {
        yield ConferenceFailure(error: error.toString());
      }
    }

    if (event is LoadMoreConferencesEvent) {
      try {
        if (conferencePagination.page < conferencePagination.totalPages) {
          conferencePagination = await conferenceService.getConferences(
            conferencePagination.page + 1, conferencePagination.size);
          conferences.addAll(conferencePagination.items);
        }
        yield LoadedConferences(conferences: conferences);
      } catch (error) {
        yield ConferenceFailure(error: error.toString());
      }
    }
  }
}
