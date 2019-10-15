import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/api/document/document.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/loading/loading_indicator.dart';
import 'package:hosrem_app/pdf/pdf_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'bloc/documents_bloc.dart';
import 'bloc/documents_event.dart';
import 'bloc/documents_state.dart';
import 'conference_resource_item.dart';
import 'document_service.dart';

/// Conference resources page.
class ConferenceResources extends StatefulWidget {
  const ConferenceResources(this.conference);

  final Conference conference;

  @override
  State<ConferenceResources> createState() => _ConferenceResourcesState();
}

class _ConferenceResourcesState extends BaseState<ConferenceResources> {
  DocumentsBloc _documentsBloc;
  DocumentService _documentService;

  List<Document> _documents;
  List<String> _supplementDocs;

  @override
  void initState() {
    super.initState();

    _supplementDocs = widget.conference.files;
    _documentService = DocumentService(apiProvider);
    _documentsBloc = DocumentsBloc(documentService: _documentService);
    _documentsBloc.dispatch(LoadDocumentByConferenceIdEvent(conferenceId: widget.conference.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DocumentsBloc>(
      builder: (BuildContext context) => _documentsBloc,
      child: BlocListener<DocumentsBloc, DocumentsState>(
        listener: (BuildContext context, DocumentsState state) {
          if (state is DocumentsFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<DocumentsBloc, DocumentsState>(
          bloc: _documentsBloc,
          builder: (BuildContext context, DocumentsState state) {
            if (state is LoadedDocumentsState) {
              _documents = state.documents;
              if (_documents.isEmpty && _supplementDocs.isEmpty) {
                return Center(
                  child: Text(
                    AppLocalizations.of(context).tr('conferences.documents.no_document_found'),
                    style: const TextStyle(
                      color: AppColors.editTextFieldTitleColor,
                      fontSize: 16.0
                    )
                  )
                );
              }
              return ListView(
                children: <Widget>[
                  _documents.isEmpty ? Container() : StickyHeader(
                    header: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 19.0),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context).tr('conferences.documents.main_documents'),
                            style: const TextStyle(
                              color: AppColors.editTextFieldTitleColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0
                            )
                          )
                        ]
                      )
                    ),
                    content: Column(
                      children: _documents.map((Document document) => InkWell(
                        child: Column(
                          children: <Widget>[
                            ConferenceResourceItem(document),
                            const Divider()
                          ],
                        ),
                        onTap: () => navigateToPdfViewer(document.title, document.content)
                      )).toList()
                    )
                  ),
                  _supplementDocs.isEmpty ? Container() : StickyHeader(
                    header: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 19.0),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context).tr('conferences.documents.supplement_documents'),
                            style: const TextStyle(
                              color: AppColors.editTextFieldTitleColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0
                            )
                          )
                        ]
                      )
                    ),
                    content: Column(
                      children: _supplementDocs.map((String file) => Document('id', file, null, null, null, null, null, docType: 'jpg')).map((Document document) => InkWell(
                        child: Column(
                          children: <Widget>[
                            ConferenceResourceItem(document),
                            const Divider()
                          ],
                        ),
                        onTap: () => navigateToPdfViewer(document.title, document.content)
                      )).toList()
                    )
                  )
                ]
              );
            }

            return LoadingIndicator();
          }
        )
      )
    );
  }

  void navigateToPdfViewer(String title, String pdfUrl) {
    Navigator.push<dynamic>(context, PageTransition<dynamic>(
      type: PageTransitionType.downToUp,
      child: PdfPage(
        url: 'http://hosrem.org.vn/public/frontend/upload/YHSS_47/02.pdf',
        name: title ?? 'Tài liệu tham khảo'
      )
    ));
  }

  @override
  void dispose() {
    _documentsBloc.dispose();
    super.dispose();
  }
}
