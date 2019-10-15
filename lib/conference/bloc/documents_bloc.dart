import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/document/document_pagination.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/conference/document_service.dart';

import 'documents_event.dart';
import 'documents_state.dart';

/// Document bloc to load documents by conference Id.
class DocumentsBloc extends Bloc<DocumentsEvent, DocumentsState> {
  DocumentsBloc({@required this.documentService}) : assert(documentService != null);

  static const int DEFAULT_PAGE = 0;
  static const int DEFAULT_PAGE_SIZE = 1000;

  final DocumentService documentService;

  @override
  DocumentsState get initialState => DocumentsLoading();

  @override
  Stream<DocumentsState> mapEventToState(DocumentsEvent event) async* {
    if (event is LoadDocumentByConferenceIdEvent) {
      try {
        final DocumentPagination documentPagination =
            await documentService.getDocumentsByConferenceId(event.conferenceId, DEFAULT_PAGE, DEFAULT_PAGE_SIZE);
        yield LoadedDocumentsState(documents: documentPagination.items);
      } catch (error) {
        yield DocumentsFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }
}
