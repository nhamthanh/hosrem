import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/api/document/document.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/image/image_viewer.dart';
import 'package:hosrem_app/loading/loading_indicator.dart';
import 'package:hosrem_app/pdf/pdf_page.dart';
import 'package:hosrem_app/widget/button/default_button.dart';
import 'package:hosrem_app/widget/text/search_text_field.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'bloc/documents_bloc.dart';
import 'bloc/documents_event.dart';
import 'bloc/documents_state.dart';
import 'conference_resource_item.dart';
import 'conference_service.dart';
import 'document_service.dart';
import 'login_conference.dart';

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

    _documentsBloc = DocumentsBloc(DocumentService(apiProvider), AuthService(apiProvider),
          ConferenceService(apiProvider));
    _documentsBloc.dispatch(CheckIfUnlockConferenceEvent(widget.conference));
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

          if (state is ConferenceUnlockState) {
            if (state.unlocked) {
              _documentsBloc.dispatch(LoadDocumentByConferenceIdEvent(widget.conference, widget.conference.files));
            }
          }
        },
        child: BlocBuilder<DocumentsBloc, DocumentsState>(
          bloc: _documentsBloc,
          builder: (BuildContext context, DocumentsState state) {
            return _buildPageContent(state);
          }
        )
      )
    );
  }

  Future<void> _navigateToLoginConference() async {
    final bool result = await pushWidgetWithTransitionResult(LoginConference(widget.conference), PageTransitionType.downToUp);
    if (result != null && result) {
      _documentsBloc.dispatch(CheckIfUnlockConferenceEvent(widget.conference));
    }
  }

  Widget _buildPageContent(DocumentsState state) {
    if (state is ConferenceUnlockState) {
      if (!state.unlocked) {
        if (state.loggedIn) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                AppLocalizations.of(context).tr('conferences.documents.upgrade_to_view_documents'),
                style: TextStyles.textStyle16PrimaryBlack,
                textAlign: TextAlign.center
              )
            )
          );
        }

        return Container(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Text(
                    'Vui lòng cung cấp thông tin về hội nghị',
                    style: TextStyles.textStyle16PrimaryBlack,
                    textAlign: TextAlign.center
                  )
                )
              ),
              const SizedBox(height: 10.0),
              DefaultButton(
                text: 'Đăng Nhập',
                onPressed: _navigateToLoginConference,
              )
            ],
          )
        );
      }

      return Container();
    }

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
      key: ObjectKey(state.documents.hashCode + state.supplementDocs.hashCode),
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
              onTap: () => _navigateToViewer(document.title, document.content)
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
              onTap: () => _navigateToViewer(document.title, document.content)
            )).toList()
          )
        ),
        !state.hasToken ? Container(
          padding: const EdgeInsets.only(left: 25.0, top: 21.5, bottom: 28.5, right: 25.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DefaultButton(
                text: 'Đăng Xuất',
                onPressed: () => _documentsBloc.dispatch(LogoutConferenceEvent(widget.conference))
              )
            ],
          )
        ) : Container()
      ]
    );
  }

  void _searchDocuments(String value) {
    _documentsBloc.dispatch(FilterDocumentsEvent(filterText: value));
  }

  void _navigateToViewer(String title, String content) {
    (content?.toLowerCase() ?? '').endsWith('pdf') ? _navigateToPdfViewer(title, content) : _navigateToImageViewer(title, content);
  }

  Future<void> _navigateToPdfViewer(String title, String content) async {
    final String pdfUrl = content != null && content.isNotEmpty ? '${apiConfig.apiBaseUrl}conferences/${widget.conference.id}/document?fileName=$content' : 'http://';
    await pushWidgetWithTransition(
      PdfPage(url: pdfUrl, name: title ?? AppLocalizations.of(context).tr('conferences.documents.reference_documents')),
      PageTransitionType.downToUp
    );
  }

  Future<void> _navigateToImageViewer(String title, String content) async {
    final String imageUrl = content != null && content.isNotEmpty ? '${apiConfig.apiBaseUrl}conferences/${widget.conference.id}/document?fileName=$content' : 'http://';
    await pushWidgetWithTransition(
      ImageViewer(url: imageUrl, title: title ?? AppLocalizations.of(context).tr('conferences.documents.reference_documents')),
      PageTransitionType.downToUp
    );
  }

  @override
  void dispose() {
    _documentsBloc.dispose();
    super.dispose();
  }
}
