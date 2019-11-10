import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/api/article/article.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/date_time_utils.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/widget/svg/svg_icon.dart';

/// Article item.
@immutable
class ArticleItem extends StatelessWidget {
  const ArticleItem(this.article, { Key key }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      height: 96.0,
      decoration: BoxDecoration(
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: AppColors.boxShadowColor,
            offset: Offset(0.0, 2.0),
            blurRadius: 4.0,
            spreadRadius: 0.0
          )
        ],
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: 80.0,
            width: 80.0,
            margin: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              imageUrl: article.avatar ?? 'https://',
              imageBuilder: (BuildContext context, ImageProvider imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: const Color.fromRGBO(52, 169, 255, 0.1),
                  image: DecorationImage(
                    image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (BuildContext context, String url) => Center(child: const CircularProgressIndicator()),
              errorWidget: (BuildContext context, String url, Object error) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: const Color.fromRGBO(52, 169, 255, 0.1),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(AppAssets.articlePlaceholder).image
                  )
                ),
              )
            )
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      article.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyles.textStyle16PrimaryBlack
                    )
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: SvgIcon(AppAssets.calendarIcon, size: 16.0, color: AppColors.secondaryGreyColor)
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        DateTimeUtils.format(article.publishTime.toLocal()),
                        style: TextStyles.textStyle10PrimaryRed
                      ),
                    ],
                  ),
                ],
              )
            ),

          )
        ],
      )
    );
  }
}
