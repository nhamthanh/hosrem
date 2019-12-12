import 'dart:typed_data';

import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:epub/epub.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as image;
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/rotation_state.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/conference/document_service.dart';
import 'package:hosrem_app/epub/bloc/epub_bloc.dart';
import 'package:hosrem_app/epub/bloc/epub_event.dart';
import 'package:hosrem_app/epub/bloc/epub_state.dart';
import 'package:hosrem_app/loading/loading_indicator.dart';
import 'package:epub/epub.dart' as epub;

// Epub Viewer class to view epub file
class EpubViewer extends StatefulWidget {

  const EpubViewer({ Key key, @required this.url, this.title}) : super(key: key);

  final String url;
  final String title;

  @override
  _EpubViewerState createState() => _EpubViewerState();
}

class _EpubViewerState extends RotationState<EpubViewer> {
  Future<epub.EpubBookRef> book;

  EpubBloc _epubBloc;

  @override
  void initState() {
    super.initState();
    _epubBloc = EpubBloc(documentService: DocumentService(apiProvider), authService: AuthService(apiProvider));
    _epubBloc.dispatch(LoadEpubEvent(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EpubBloc, EpubState>(
      bloc: _epubBloc,
      builder: (BuildContext context, EpubState state) {
        return Scaffold(
          appBar: widget.title != null ? AppBar(
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    widget.title,
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
          ) : null,
          body: buildEpubWidget(state)
        );
      }
    );
  }

  Widget buildEpubWidget(EpubState state) {
    if (state is LoadedEpub) {
      final EpubBook book = state.epubBook;
      final int length = book.Chapters != null ? book.Chapters.length + 1 : 1;
      if (book != null) {
        return ListView.builder(
          itemCount: length,
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          itemBuilder: (BuildContext ctxt, int index) {
            if (index == 0) {
              return Column (children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                ),
                book.CoverImage != null ? material.Image.memory(image.encodePng(book.CoverImage)) : Container(),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                ),
                Text(
                  book.Title ?? '',
                  style: TextStyles.textStyle26PrimaryBlackBold,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                ),
              ],);
            } else {
              return Html(data: book.Chapters[index - 1].HtmlContent);
            }
          }
        );
      } else {
        return Container();
      }
    }
    if (state is EpubFailure) {
      return Center(
        child: Text(
          AppLocalizations.of(context).tr('conferences.details.no_document_found'),
          style: TextStyles.textStyle16PrimaryBlack
        )
      );
    }
    return LoadingIndicator();
  }
}