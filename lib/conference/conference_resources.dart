import 'package:flutter/material.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/api/conference/document.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/pdf/pdf_page.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'bloc/conference_resources_bloc.dart';
import 'conference_resource_item.dart';
import 'conference_service.dart';

/// Conference resources page.
class ConferenceResources extends StatefulWidget {
  const ConferenceResources(this.conference);

  final Conference conference;

  @override
  State<ConferenceResources> createState() => _ConferenceResourcesState();
}

class _ConferenceResourcesState extends BaseState<ConferenceResources> {
  ConferenceResourcesBloc _conferenceResourcesBloc;
  ConferenceService _conferenceService;

  List<Document> _documents;
  List<String> _supplementDocs;

  @override
  void initState() {
    super.initState();

    _supplementDocs = widget.conference.files.isEmpty ? <String>[
      'https://miro.medium.com/max/3400/1*0c3heWwzJO4tTZFvjM4NaA.jpeg',
      'https://miro.medium.com/max/3400/1*0c3heWwzJO4tTZFvjM4NaA.jpeg',
      'https://miro.medium.com/max/3400/1*0c3heWwzJO4tTZFvjM4NaA.jpeg',
      'https://miro.medium.com/max/3400/1*0c3heWwzJO4tTZFvjM4NaA.jpeg',
      'https://miro.medium.com/max/3400/1*0c3heWwzJO4tTZFvjM4NaA.jpeg'
    ] : widget.conference.files;

    _documents = widget.conference.documents ?? <Document>[
      Document('id', 'https://miro.medium.com/max/3400/1*0c3heWwzJO4tTZFvjM4NaA.jpeg', null, null, null, null, 'Hoi nghi thuong nien', docType: 'jpg'),
      Document('id', 'https://miro.medium.com/max/3400/1*0c3heWwzJO4tTZFvjM4NaA.jpeg', null, null, null, null, 'Hoi nghi thuong nien', docType: 'jpg'),
      Document('id', 'https://miro.medium.com/max/3400/1*0c3heWwzJO4tTZFvjM4NaA.jpeg', null, null, null, null, 'Hoi nghi thuong nien'),
      Document('id', 'https://miro.medium.com/max/3400/1*0c3heWwzJO4tTZFvjM4NaA.jpeg', null, null, null, null, 'Hoi nghi thuong nien'),
      Document('id', 'https://miro.medium.com/max/3400/1*0c3heWwzJO4tTZFvjM4NaA.jpeg', null, null, null, null, 'Hoi nghi thuong nien'),
      Document('id', 'https://miro.medium.com/max/3400/1*0c3heWwzJO4tTZFvjM4NaA.jpeg', null, null, null, null, 'Hoi nghi thuong nien'),
      Document('id', 'https://miro.medium.com/max/3400/1*0c3heWwzJO4tTZFvjM4NaA.jpeg', null, null, null, null, 'Hoi nghi thuong nien'),
      Document('id', 'https://miro.medium.com/max/3400/1*0c3heWwzJO4tTZFvjM4NaA.jpeg', null, null, null, null, 'Hoi nghi thuong nien'),
      Document('id', 'https://miro.medium.com/max/3400/1*0c3heWwzJO4tTZFvjM4NaA.jpeg', null, null, null, null, 'Hoi nghi thuong nien')
    ];

    _conferenceService = ConferenceService(apiProvider);
    _conferenceResourcesBloc = ConferenceResourcesBloc(conferenceService: _conferenceService);
  }

  @override
  Widget build(BuildContext context) {
    if (_documents.isEmpty && _supplementDocs.isEmpty) {
      return Center(
        child: const Text(
          'No document found',
          style: TextStyle(
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
            child: const Text(
              'Main Document',
              style: TextStyle(
                color: AppColors.editTextFieldTitleColor,
                fontWeight: FontWeight.w600,
                fontSize: 16.0
              )
            ),
          ),
          content: Column(
            children: _documents.map((Document document) => InkWell(
              child: Column(
                children: <Widget>[
                  ConferenceResourceItem(document),
                  const Divider()
                ],
              ),
              onTap: () => navigateToPdfViewer(document.content)
            )).toList()
          )
        ),
        _supplementDocs.isEmpty ? Container() : StickyHeader(
          header: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 19.0),
            color: Colors.white,
            child: const Text(
              'Supplement Document',
              style: TextStyle(
                color: AppColors.editTextFieldTitleColor,
                fontWeight: FontWeight.w600,
                fontSize: 16.0
              )
            )
          ),
          content: Column(
            children: _supplementDocs.map((String file) => Document('id', 'https://miro.medium.com/max/3400/1*0c3heWwzJO4tTZFvjM4NaA.jpeg', null, null, null, null, 'Hoi nghi thuong nien')).map((Document document) => InkWell(
              child: Column(
                children: <Widget>[
                  ConferenceResourceItem(document),
                  const Divider()
                ],
              ),
              onTap: () => navigateToPdfViewer(document.content)
            )).toList()
          )
        )
      ]
    );
  }

  void navigateToPdfViewer(String pdfUrl) {
    Navigator.push(
      context,
      MaterialPageRoute<bool>(builder: (BuildContext context) => const PdfPage(url: 'http://hosrem.org.vn/public/frontend/upload/YHSS_47/02.pdf'))
    );
  }

  @override
  void dispose() {
    _conferenceResourcesBloc.dispose();
    super.dispose();
  }
}
