import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/conference/conference_auth.dart';
import 'package:hosrem_app/api/conference/user_conference.dart';
import 'package:hosrem_app/api/document/document.dart';
import 'package:hosrem_app/api/document/document_pagination.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/conference/document_service.dart';
import 'package:hosrem_app/profile/user_service.dart';
import 'package:logging/logging.dart';

import '../conference_service.dart';
import 'documents_event.dart';
import 'documents_state.dart';

/// Document bloc to load documents by conference Id.
class DocumentsBloc extends Bloc<DocumentsEvent, DocumentsState> {
  DocumentsBloc(this.documentService, this.authService, this.conferenceService, this.userService);

  static const int DEFAULT_PAGE = 0;
  static const int DEFAULT_PAGE_SIZE = 1000;

  final Logger _logger = Logger('DocumentsBloc');

  final DocumentService documentService;
  final UserService userService;
  final ConferenceService conferenceService;
  final AuthService authService;

  List<Document> _supplementDocs;
  List<Document> _documents;

  @override
  DocumentsState get initialState => DocumentsLoading();

  @override
  Stream<DocumentsState> mapEventToState(DocumentsEvent event) async* {
    if (event is CheckIfUnlockConferenceEvent) {
      try {
        yield DocumentsLoading();
        final User currentUser = await authService.currentUser();
        final ConferenceAuth conferenceAuth = await authService.getConferenceAuth(event.conference.id);
        final bool registeredConference = currentUser == null ? conferenceAuth != null :
            await conferenceService.checkIfUserRegisterConference(event.conference.id, currentUser.id);
        bool showLoginConference = conferenceAuth == null;
        if (currentUser != null) {
          showLoginConference = false;
          final UserConference userConference = await userService.getSpecificRegisteredConference(event.conference.id);
          if (userConference != null) {
            showLoginConference = userConference.status != 'Confirmed';
          }
        }
        yield ConferenceUnlockState(showLoginRegistration: showLoginConference, unlocked: registeredConference);
      } catch (error) {
        _logger.fine(error);
        yield DocumentsFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is LoadDocumentByConferenceIdEvent) {
      try {
        yield DocumentsLoading();
        final DocumentPagination documentPagination = await documentService.getDocuments(
          event.conference.id, DocumentService.SPEAKER_DOCUMENT_TYPE, DEFAULT_PAGE, DEFAULT_PAGE_SIZE);
        final DocumentPagination otherDocumentPagination = await documentService.getDocuments(
          event.conference.id, DocumentService.OTHER_DOCUMENT_TYPE, DEFAULT_PAGE, DEFAULT_PAGE_SIZE, sort: 'title:asc');
        _documents = documentPagination.items;
        _supplementDocs = otherDocumentPagination.items;

        yield LoadedDocumentsState(
          hasToken: await authService.hasToken(),
          documents: documentPagination.items,
          supplementDocs: _supplementDocs
        );
      } catch (error) {
        _logger.fine(error);
        yield DocumentsFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is FilterDocumentsEvent) {
      try {
        final List<Document> filteredDocuments =
            _documents.where((Document d) => _filterText(d, event.filterText)).toList();
        final List<Document> filteredSupplementDocs =
            _supplementDocs.where((Document d) => _filterText(d, event.filterText)).toList();
        yield LoadedDocumentsState(
          hasToken: await authService.hasToken(),
          documents: filteredDocuments,
          supplementDocs: filteredSupplementDocs
        );
      } catch (error) {
        _logger.fine(error);
        yield DocumentsFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is LogoutConferenceEvent) {
      try {
        await authService.clearUser();
        dispatch(CheckIfUnlockConferenceEvent(event.conference));
      } catch (error) {
        _logger.fine(error);
        yield DocumentsFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }

  bool _filterText(Document document, String filter) {
    final String title = document.title?.toLowerCase() ?? '';
    final String speakers = document.speakers?.toLowerCase() ?? '';
    final String filterLowerCase = filter.toLowerCase();
    return title.contains(filterLowerCase) || speakers.contains(filterLowerCase);
  }
}
