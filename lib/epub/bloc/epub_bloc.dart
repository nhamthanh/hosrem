import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:epub/epub.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/conference/document_service.dart';
import 'package:meta/meta.dart';

import 'epub_event.dart';
import 'epub_state.dart';

/// Epub bloc to load Epub.
class EpubBloc extends Bloc<EpubEvent, EpubState> {
  EpubBloc({
    @required this.documentService,
    @required this.authService,
  })  : assert(documentService != null);

  final DocumentService documentService;
  final AuthService authService;

  @override
  EpubState get initialState => EpubLoading();

  @override
  Stream<EpubState> mapEventToState(EpubEvent event) async* {
    if (event is LoadEpubEvent) {
      yield EpubLoading();
      try {
        final String token = await authService.getToken();
        final File file = await documentService.getDocumentFromCacheOrDownload(event.url, token);
        final List<int> bytes = await file.readAsBytes();
        // Opens a book and reads all of its content into the memory
        final EpubBook epubBook = await EpubReader.readBook(bytes);
        yield LoadedEpub(epubBook: epubBook);
      } catch (error) {
        yield EpubFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }
}
