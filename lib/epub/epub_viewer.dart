import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:epub/epub.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
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
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart' as dom;

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
          appBar: AppBar(
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
          ),
          body: buildEpubWidget(state)
        );
      }
    );
  }

  Widget buildEpubWidget(EpubState state) {
    if (state is LoadedEpub) {
      final EpubBook book = state.epubBook;
      final int length = book.Chapters != null ? book.Chapters.length + 1 : 1;
        print(book.Content.Css);
                       print(book.Content.Fonts);
      if (book != null) {
        return Container(
          //color: const Color.fromRGBO(0, 0, 0, 0.8),
          child: ListView.builder(
            itemCount: length,
            padding: const EdgeInsets.only(left: 8.0, right: 7.0),
            itemBuilder: (BuildContext ctxt, int index) {
              if (index == 0) {
                return Column (children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 15.0),
                  ),
                  book.CoverImage != null ? material.Image.memory(image.encodePng(book.CoverImage)) : Container(),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  Text(
                    book.Title ?? '',
                    style: TextStyles.textStyle26PrimaryWhiteBold,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15.0),
                  ),
                ],);
              } else {
                print(book.Chapters[index - 1].HtmlContent);

                // return Html(
                //   onLinkTap: (String url) async {
                //     if (await canLaunch(url)) {
                //       await launch(url);
                //     }
                //   },
                //   // customTextStyle: (dom.Node node, TextStyle baseStyle) {
                //   //   if (node is dom.Element) {
                //   //     switch (node.localName) {
                //   //       case 'p' :
                //   //         return baseStyle.merge(TextStyle(height: 1.6, fontSize: 16, color: Colors.white));
                //   //       case 'h1' :
                //   //       case 'h2' :
                //   //       case 'h3' :
                //   //       case 'h4' :
                //   //       case 'h5' :
                //   //       case 'div' :
                //   //         return baseStyle.merge(TextStyle(color: Colors.white));
                //   //     }
                //   //   }
                //   //   return baseStyle;
                //   // },
                //   data: book.Chapters[index - 1].HtmlContent
                // );
                return WebviewScaffold(
                  url: book.Chapters[index - 1].HtmlContent,
                  withZoom: false,
                );
                // return HtmlWidget(
                //   book.Chapters[index - 1].HtmlContent,
                //   onTapUrl: (String url) async {
                //     if (await canLaunch(url)) {
                //       await launch(url);
                //     }
                //   },
                // );
              }
            }
          )
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