import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hosrem_app/api/document/document.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/text_styles.dart';

/// Conference resource item.
@immutable
class ConferenceResourceItem extends StatelessWidget {
  const ConferenceResourceItem(this.document);

  final Document document;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 20.0, bottom: 20.0),
          child: SvgPicture.asset(
            (document?.content?.toLowerCase()?? '').endsWith('pdf') ? AppAssets.pdfFileType : 
            (document?.content?.toLowerCase()?? '').endsWith('epub') ? AppAssets.epubFileType : AppAssets.jpgFileType,
            height: 60.0,
            width: 60.0
          )
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                document.title ?? 'Tài liệu tham khảo',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.textStyle16PrimaryBlack
              ),
              Text(
                document.speakers ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.textStyle14SecondaryGrey
              )
            ],
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            child: Icon(Icons.arrow_forward_ios, size: 18.0)
          )
        )
      ],
    );
  }
}
