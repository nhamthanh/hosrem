import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/api/document/document_pagination.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/conference/document_service.dart';
import 'package:logging/logging.dart';

import '../conference_service.dart';
import 'conference_event.dart';
import 'conference_state.dart';

/// Conference bloc to load conference by id.
class ConferenceBloc extends Bloc<ConferenceEvent, ConferenceState> {
  ConferenceBloc({@required this.conferenceService, @required this.documentService})
    : assert(conferenceService != null), assert(documentService != null);

  static const int DEFAULT_PAGE = 0;
  static const int DEFAULT_PAGE_SIZE = 1000;

  final ConferenceService conferenceService;
  final DocumentService documentService;
  final Logger _logger = Logger('ConferenceBloc');

  @override
  ConferenceState get initialState => ConferenceInitial();

  @override
  Stream<ConferenceState> mapEventToState(ConferenceEvent event) async* {
    if (event is LoadConferenceEvent) {
      
      yield ConferenceLoading();
      try {
        final Conference conference = await conferenceService.getConferenceById(event.conferenceId);

        final DocumentPagination documentPagination =
            await documentService.getDocumentsByConferenceId(event.conferenceId, DocumentService.OTHER_DOCUMENT_TYPE,
                DEFAULT_PAGE, DEFAULT_PAGE_SIZE);
        yield LoadedConferenceState(
          conference: conference,
          documents: documentPagination.items,
        );
      } catch (error) {
        _logger.fine(error);
        yield ConferenceFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }
}