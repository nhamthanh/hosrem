import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/conference/conference_registration.dart';
import 'package:hosrem_app/api/document/document.dart';
import 'package:hosrem_app/api/document/document_pagination.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/conference/document_service.dart';
import 'package:logging/logging.dart';

import '../conference_service.dart';
import 'documents_event.dart';
import 'documents_state.dart';

/// Document bloc to load documents by conference Id.
class DocumentsBloc extends Bloc<DocumentsEvent, DocumentsState> {
  DocumentsBloc(this.documentService, this.authService, this.conferenceService);

  static const int DEFAULT_PAGE = 0;
  static const int DEFAULT_PAGE_SIZE = 1000;

  final DocumentService documentService;
  final ConferenceService conferenceService;
  final AuthService authService;
  final Logger _logger = Logger('DocumentsBloc');

  final Map<String, bool> _fields = <String, bool>{};
  List<Document> _supplementDocs;
  List<Document> _documents;


  @override
  DocumentsState get initialState {
    _fields['fullName'] = true;
    _fields['registrationCode'] = true;
    return DocumentsLoading();
  }

  @override
  Stream<DocumentsState> mapEventToState(DocumentsEvent event) async* {
    if (event is CheckIfUnlockConferenceEvent) {
      try {
        yield DocumentsLoading();
        final User currentUser = await authService.currentUser();
        final bool registeredConference = currentUser == null ?
            await authService.isRegisteredConference(event.conference.id) :
            await conferenceService.checkIfUserRegisterConference(event.conference.id, currentUser.id);
        yield ConferenceUnlockState(fields: _fields, loggedIn: currentUser != null, unlocked: registeredConference);
      } catch (error) {
        _logger.fine(error);
        yield ConferenceUnlockState(fields: _fields, errorMsg: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is LoadDocumentByConferenceIdEvent) {
      try {
        yield DocumentsLoading();
        final DocumentPagination documentPagination = await documentService.getDocumentsByConferenceId(
          event.conference.id, DocumentService.SPEAKER_DOCUMENT_TYPE, DEFAULT_PAGE, DEFAULT_PAGE_SIZE);
        final DocumentPagination otherDocumentPagination = await documentService.getDocumentsByConferenceId(
          event.conference.id, DocumentService.OTHER_DOCUMENT_TYPE, DEFAULT_PAGE, DEFAULT_PAGE_SIZE);
        _documents = documentPagination.items;
        _supplementDocs = otherDocumentPagination.items;

        yield LoadedDocumentsState(
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
          documents: filteredDocuments,
          supplementDocs: filteredSupplementDocs
        );
      } catch (error) {
        _logger.fine(error);
        yield DocumentsFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is ValidateFormFieldEvent) {
      try {
        _fields[event.name] = event.value.isNotEmpty;
        yield ConferenceUnlockState(fields: _fields);
      } catch (error) {
        _logger.fine(error);
        yield DocumentsFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is ViewDocumentsPressedEvent) {
      try {
        yield ConferenceUnlockState(fields: _fields, loading: true);

        if (event.fullName.isEmpty || event.registrationCode.isEmpty) {
          _fields['fullName'] = event.fullName.isNotEmpty;
          _fields['registrationCode'] = event.registrationCode.isNotEmpty;
          yield ConferenceUnlockState(fields: _fields);
          return;
        }

        final ConferenceRegistration conferenceRegistration =
          await conferenceService.getRegistrationInfoFromRegCode(event.conference.id, event.registrationCode);
        if (conferenceRegistration?.user?.fullName != event.fullName) {
          yield ConferenceUnlockState(fields: _fields, errorMsg: 'Tên hoặc mã hội nghị của bạn không đúng. Vui lòng thử lại.');
          return;
        }

        await authService.persistRegistrationCode(event.conference.id, event.registrationCode);
        dispatch(LoadDocumentByConferenceIdEvent(event.conference, event.supplementDocs));
      } catch (error) {
        _logger.fine(error);
        yield ConferenceUnlockState(fields: _fields, errorMsg: ErrorHandler.extractErrorMessage(error));
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
