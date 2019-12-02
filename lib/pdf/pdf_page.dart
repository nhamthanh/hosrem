import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/rotation_state.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/conference/document_service.dart';
import 'package:hosrem_app/loading/loading_indicator.dart';
import 'package:hosrem_app/pdf/pdf_viewer.dart';

import 'bloc/pdf_bloc.dart';
import 'bloc/pdf_event.dart';
import 'bloc/pdf_state.dart';

/// Pdf page.
@immutable
class PdfPage extends StatefulWidget {
  const PdfPage({Key key, this.url, this.name}) : super(key: key);

  final String url;
  final String name;

  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends RotationState<PdfPage> {
  PdfBloc _pdfBloc;
  AppBar _appBar;

  @override
  void initState() {
    super.initState();
    _pdfBloc = PdfBloc(documentService: DocumentService(apiProvider), authService: AuthService(apiProvider));
    _pdfBloc.dispatch(LoadPdfEvent(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PdfBloc, PdfState>(
      bloc: _pdfBloc,
      builder: (BuildContext context, PdfState state) {
        _appBar = AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.textStyle14PrimaryWhite
                ),
              ),
              IconButton(
                icon: Icon(Icons.clear),
                color: Colors.white,
                onPressed: () => Navigator.pop(context)
              )
            ],
          ),
          automaticallyImplyLeading: false
        );
        return Scaffold(
          appBar: _appBar,
          body: _buildPdfWidget(state, context)
        );
      }
    );
  }

  Widget _buildPdfWidget(PdfState state, BuildContext context) {
    if (state is LoadedPdf) {
      return PdfViewer(
        url: widget.url,
        top: _appBar.preferredSize.height + MediaQuery.of(context).padding.top,
        width: _calculatePdfWidth(context),
        height: _calculatePdfHeight(context),
      );
    }

    if (state is PdfFailure) {
      return Center(
        child: Text(
          AppLocalizations.of(context).tr('conferences.documents.no_document_found'),
          style: TextStyles.textStyle16PrimaryBlack
        )
      );
    }

    return LoadingIndicator();
  }

  double _calculatePdfHeight(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double top = _appBar.preferredSize.height;
    double height = mediaQuery.size.height - top;
    if (height < 0.0) {
      height = 0.0;
    }

    return height;
  }

  double _calculatePdfWidth(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.width;
  }

}
