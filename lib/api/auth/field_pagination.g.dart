// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldPagination _$FieldPaginationFromJson(Map<String, dynamic> json) {
  return FieldPagination(
    json['totalSize'] as int,
    json['page'] as int,
    json['totalPage'] as int,
    json['size'] as int,
    (json['result'] as List)
        .map((e) => Field.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FieldPaginationToJson(FieldPagination instance) =>
    <String, dynamic>{
      'totalSize': instance.totalItems,
      'page': instance.page,
      'totalPage': instance.totalPages,
      'size': instance.size,
      'result': instance.items,
    };
