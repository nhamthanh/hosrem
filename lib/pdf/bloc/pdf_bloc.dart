import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/conference/document_service.dart';
import 'package:meta/meta.dart';

import 'pdf_event.dart';
import 'pdf_state.dart';

/// Pdf bloc to load pdf.
class PdfBloc extends Bloc<PdfEvent, PdfState> {
  PdfBloc({
    @required this.documentService,
    @required this.authService,
  })  : assert(documentService != null);

  final DocumentService documentService;
  final AuthService authService;

  @override
  PdfState get initialState => PdfLoading();

  @override
  Stream<PdfState> mapEventToState(PdfEvent event) async* {
    if (event is LoadPdfEvent) {
      yield PdfLoading();
      try {
        final String token = await authService.getToken();
        final File file = await documentService.getDocumentFromCacheOrDownload(event.url, token);
        yield LoadedPdf(path: file.path);
      } catch (error) {
        yield PdfFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }
}
