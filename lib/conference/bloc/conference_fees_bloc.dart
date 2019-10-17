import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/conference/conference_fees.dart';
import 'package:hosrem_app/common/error_handler.dart';

import '../conference_service.dart';
import 'conference_fees_event.dart';
import 'conference_fees_state.dart';

/// Conference fees bloc.
class ConferenceFeesBloc extends Bloc<ConferenceFeesEvent, ConferenceFeesState> {
  ConferenceFeesBloc({@required this.conferenceService}) : assert(conferenceService != null);

  static const int DEFAULT_PAGE = 0;
  static const int DEFAULT_PAGE_SIZE = 1000;

  final ConferenceService conferenceService;

  @override
  ConferenceFeesState get initialState => ConferenceFeesLoading();

  @override
  Stream<ConferenceFeesState> mapEventToState(ConferenceFeesEvent event) async* {
    if (event is LoadConferenceFeesByConferenceIdEvent) {
      try {
        final ConferenceFees conferenceFees =
            await conferenceService.getConferenceFees(event.conferenceId);
        yield LoadedConferenceFees(conferenceFees: conferenceFees);
      } catch (error) {
        yield ConferenceFeesFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }
}
