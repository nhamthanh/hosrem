
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

/// Custom html display library.
@immutable
class CustomHtml extends StatelessWidget {
  const CustomHtml(this.content);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: content,
      useRichText: false,
      padding: const EdgeInsets.all(8.0),
      onLinkTap: (String url) async {
        if (await canLaunch(url)) {
          await launch(url);
        }
      },
      customRender: (dom.Node node, List<Widget> children) {
        if (node is dom.Element) {
          if (node.localName == 'li') {
            final String type = node.parent.localName; // Parent type; usually ol or ul
            const EdgeInsets markPadding = EdgeInsets.symmetric(horizontal: 7.0);
            Widget mark;
            switch (type) {
              case 'ul':
                mark = Container(child: const Text('•'), padding: markPadding);
                break;
              case 'ol':
                final int index = node.parent.children.indexOf(node) + 1;
                mark = Container(child: Text('$index.'), padding: markPadding);
                break;
              default: //Fallback to middle dot
                mark = Container(width: 0.0, height: 0.0);
                break;
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  mark,
                  Expanded(
                    child: Column(
                      children: HtmlOldParser(width: null,).parse(node.text),
                    )
                  )
                ],
              )
            );
          }
          if (node.localName == 'em') {
            if (node.hasChildNodes() && node.firstChild.toString() == '<html strong>') {
              return Text(
                node.text,
                style: TextStyles.textStyleItalicBold,
              );
            }
            return Text(
              node.text,
              style: TextStyles.textStyleItalic,
            );
          }
        }
      }
    );
  }

}
