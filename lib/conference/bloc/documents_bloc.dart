import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/document/document.dart';
import 'package:hosrem_app/api/document/document_pagination.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/conference/document_service.dart';
import 'package:logging/logging.dart';

import 'documents_event.dart';
import 'documents_state.dart';

/// Document bloc to load documents by conference Id.
class DocumentsBloc extends Bloc<DocumentsEvent, DocumentsState> {
  DocumentsBloc({@required this.documentService, @required this.authService})
    : assert(documentService != null), assert(authService != null);

  static const int DEFAULT_PAGE = 0;
  static const int DEFAULT_PAGE_SIZE = 1000;

  final DocumentService documentService;
  final AuthService authService;
  final Logger _logger = Logger('DocumentsBloc');

  List<Document> _supplementDocs;
  List<Document> _documents;
  String _token;

  @override
  DocumentsState get initialState => DocumentsLoading();

  @override
  Stream<DocumentsState> mapEventToState(DocumentsEvent event) async* {
    if (event is LoadDocumentByConferenceIdEvent) {
      try {
        final DocumentPagination documentPagination =
            await documentService.getDocumentsByConferenceId(event.conferenceId, DocumentService.SPEAKER_DOCUMENT_TYPE,
                DEFAULT_PAGE, DEFAULT_PAGE_SIZE);
        final DocumentPagination otherDocumentPagination =
            await documentService.getDocumentsByConferenceId(event.conferenceId, DocumentService.OTHER_DOCUMENT_TYPE,
                DEFAULT_PAGE, DEFAULT_PAGE_SIZE);
        _documents = documentPagination.items;
        _supplementDocs = otherDocumentPagination.items;
        _token = await authService.getToken();
        yield LoadedDocumentsState(
          documents: documentPagination.items,
          supplementDocs: _supplementDocs,
          token: _token
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
          supplementDocs: filteredSupplementDocs,
          token: _token
        );
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
