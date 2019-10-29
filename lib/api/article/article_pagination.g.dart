// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticlePagination _$ArticlePaginationFromJson(Map<String, dynamic> json) {
  return ArticlePagination(
    json['totalSize'] as int,
    json['page'] as int,
    json['totalPage'] as int,
    json['size'] as int,
    (json['result'] as List)
        .map((e) => Article.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ArticlePaginationToJson(ArticlePagination instance) =>
    <String, dynamic>{
      'totalSize': instance.totalItems,
      'page': instance.page,
      'totalPage': instance.totalPages,
      'size': instance.size,
      'result': instance.items,
    };
