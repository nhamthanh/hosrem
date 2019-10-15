// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentPagination _$DocumentPaginationFromJson(Map<String, dynamic> json) {
  return DocumentPagination(
    json['totalSize'] as int,
    json['page'] as int,
    json['totalPage'] as int,
    json['size'] as int,
    (json['result'] as List)
        .map((e) => Document.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DocumentPaginationToJson(DocumentPagination instance) =>
    <String, dynamic>{
      'totalSize': instance.totalItems,
      'page': instance.page,
      'totalPage': instance.totalPages,
      'size': instance.size,
      'result': instance.items,
    };
