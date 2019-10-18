import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/api/document/document.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/loading/loading_indicator.dart';
import 'package:hosrem_app/pdf/pdf_page.dart';
import 'package:hosrem_app/widget/text/search_text_field.dart';
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

  @override
  void initState() {
    super.initState();

    _documentsBloc = DocumentsBloc(documentService: DocumentService(apiProvider), authService: AuthService(apiProvider));
    _documentsBloc.dispatch(
      LoadDocumentByConferenceIdEvent(
        conferenceId: widget.conference.id,
        supplementDocs: widget.conference.files
      )
    );
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
              return Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 19.0, bottom: 0.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: SearchTextField(
                            executeSearch: _searchDocuments
                          )
                        ),
                      ],
                    )
                  ),
                  Expanded(
                    child: _buildDocumentsWidget(state)
                  )
                ]
              );
            }

            if (state is DocumentsFailure) {
              return Center(
                child: Text(
                  AppLocalizations.of(context).tr('conferences.documents.no_document_found'),
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

  Widget _buildDocumentsWidget(LoadedDocumentsState state) {
    if (state.documents.isEmpty && state.supplementDocs.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context).tr('conferences.documents.no_document_found'),
          style: TextStyles.textStyle16PrimaryBlack
        )
      );
    }
    return ListView(
      children: <Widget>[
        state.documents.isEmpty ? Container() : StickyHeader(
          header: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 19.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).tr('conferences.documents.main_documents'),
                  style: TextStyles.textStyle16PrimaryBlackBold
                )
              ]
            )
          ),
          content: Column(
            children: state.documents.map((Document document) => InkWell(
              child: Column(
                children: <Widget>[
                  ConferenceResourceItem(document),
                  const Divider()
                ],
              ),
              onTap: () => _navigateToPdfViewer(document.title, document.content, state.token)
            )).toList()
          )
        ),
        state.supplementDocs.isEmpty ? Container() : StickyHeader(
          header: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 19.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).tr('conferences.documents.supplement_documents'),
                  style: TextStyles.textStyle16PrimaryBlackBold
                )
              ]
            )
          ),
          content: Column(
            children: state.supplementDocs.map((Document document) => InkWell(
              child: Column(
                children: <Widget>[
                  ConferenceResourceItem(document),
                  const Divider()
                ],
              ),
              onTap: () => _navigateToPdfViewer(document.title, document.content, state.token)
            )).toList()
          )
        )
      ]
    );
  }

  void _searchDocuments(String value) {
    _documentsBloc.dispatch(FilterDocumentsEvent(filterText: value));
  }

  void _navigateToPdfViewer(String title, String content, String token) {
    final String pdfUrl = content != null && content.isNotEmpty ? '${apiConfig.apiBaseUrl}conferences/${widget.conference.id}/document?fileName=${content}' : 'http://';
    print(pdfUrl);
    Navigator.push<dynamic>(context, PageTransition<dynamic>(
      type: PageTransitionType.downToUp,
      child: PdfPage(url: pdfUrl, name: title ?? 'Tài liệu tham khảo')
    ));
  }

  @override
  void dispose() {
    _documentsBloc.dispose();
    super.dispose();
  }
}
