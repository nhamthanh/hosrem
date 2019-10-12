import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/conference/conference_service.dart';
import 'package:meta/meta.dart';

import 'pdf_event.dart';
import 'pdf_state.dart';

/// Pdf bloc to load pdf.
class PdfBloc extends Bloc<PdfEvent, PdfState> {
  PdfBloc({
    @required this.conferenceService
  })  : assert(conferenceService != null);

  final ConferenceService conferenceService;

  @override
  PdfState get initialState => PdfLoading();

  @override
  Stream<PdfState> mapEventToState(PdfEvent event) async* {
    if (event is LoadPdfEvent) {
      yield PdfLoading();
      try {
        final File file = await conferenceService.downloadResource(event.url);
        yield LoadedPdf(path: file.path);
      } catch (error) {
        yield PdfFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }
}
