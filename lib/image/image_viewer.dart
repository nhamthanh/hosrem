import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:photo_view/photo_view.dart';

import '../common/text_styles.dart';

/// Image page.
@immutable
class ImageViewer extends StatelessWidget {
  const ImageViewer({Key key, this.url, this.title}) : super(key: key);

  final String url;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
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
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(url),
          backgroundDecoration: BoxDecoration(
            color: AppColors.backgroundConferenceColor,
          ),
          loadingChild: Center(
            child: const CircularProgressIndicator(),
          ),
        )
      )
    );
  }
}
