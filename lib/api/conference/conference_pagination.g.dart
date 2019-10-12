// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conference_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConferencePagination _$ConferencePaginationFromJson(Map<String, dynamic> json) {
  return ConferencePagination(
    json['totalSize'] as int,
    json['page'] as int,
    json['totalPage'] as int,
    json['size'] as int,
    (json['result'] as List)
        .map((e) => Conference.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ConferencePaginationToJson(
        ConferencePagination instance) =>
    <String, dynamic>{
      'totalSize': instance.totalItems,
      'page': instance.page,
      'totalPage': instance.totalPages,
      'size': instance.size,
      'result': instance.items,
    };
