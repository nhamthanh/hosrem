import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
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
      appBar: title != null ? AppBar(
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
        ) : null,
      body: Center (
        child: CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (BuildContext context, ImageProvider imageProvider) => PhotoView(
            imageProvider: imageProvider,
            backgroundDecoration: BoxDecoration(
            color: AppColors.backgroundConferenceColor,
            ),
          ),
          placeholder: (BuildContext context, String url) => const CircularProgressIndicator(),
          errorWidget: (BuildContext context, String url, Object error) => Text(
            AppLocalizations.of(context).tr('conferences.details.no_document_found'),
            style: TextStyles.textStyle16PrimaryBlack
          ),
        ),
      )
    );
  }
}
