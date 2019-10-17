import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_plugin.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/conference/document_service.dart';
import 'package:hosrem_app/loading/loading_indicator.dart';

import 'bloc/pdf_bloc.dart';
import 'bloc/pdf_event.dart';
import 'bloc/pdf_state.dart';

/// Pdf viewer.
class PdfViewer extends StatefulWidget {
  const PdfViewer({
    Key key,
    @required this.url,
    @required this.top,
    @required this.height,
    @required this.width
  }) : super(key: key);

  final String url;
  final double top;
  final double height;
  final double width;

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends BaseState<PdfViewer> {
  PdfBloc _pdfBloc;

  final PDFViewerPlugin pdfViewerRef = PDFViewerPlugin();
  Rect _rect;
  Timer _resizeTimer;

  @override
  void initState() {
    super.initState();
    pdfViewerRef.close();

    _pdfBloc = PdfBloc(documentService: DocumentService(apiProvider), authService: AuthService(apiProvider));
    _pdfBloc.dispatch(LoadPdfEvent(widget.url));
  }

  @override
  void dispose() {
    super.dispose();
    pdfViewerRef.close();
    pdfViewerRef.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PdfBloc>(
      builder: (BuildContext context) => _pdfBloc,
      child: BlocListener<PdfBloc, PdfState>(
        listener: (BuildContext context, PdfState state) {
        },
        child: BlocBuilder<PdfBloc, PdfState>(
          bloc: _pdfBloc,
          builder: (BuildContext context, PdfState state) {
            if (state is LoadedPdf) {
              return _build(context, state.path);
            }
            if (state is PdfFailure) {
              return Center(
                child: const Text(
                  'Failed to load conference',
                  style: TextStyles.textStyle16PrimaryBlack
                )
              );
            }
            return LoadingIndicator();
          }
        )
      )
    );
  }

  Widget _build(BuildContext context, String path) {
    if (_rect == null) {
      _rect = _buildRect(context);
      pdfViewerRef.launch(
        path,
        rect: _rect,
      );
    } else {
      final Rect rect = _buildRect(context);
      if (_rect != rect) {
        _rect = rect;
        _resizeTimer?.cancel();
        _resizeTimer = Timer(Duration(milliseconds: 300), () {
          pdfViewerRef.resize(_rect);
        });
      }
    }
    return Center(
      child: const CircularProgressIndicator()
    );
  }

  Rect _buildRect(BuildContext context) {
    return Rect.fromLTWH(0.0, widget.top, widget.width, widget.height);
  }
}
