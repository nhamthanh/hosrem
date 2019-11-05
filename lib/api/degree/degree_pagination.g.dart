// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'degree_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DegreePagination _$DegreePaginationFromJson(Map<String, dynamic> json) {
  return DegreePagination(
    json['totalSize'] as int,
    json['page'] as int,
    json['totalPage'] as int,
    json['size'] as int,
    (json['result'] as List)
        .map((e) => Degree.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DegreePaginationToJson(DegreePagination instance) =>
    <String, dynamic>{
      'totalSize': instance.totalItems,
      'page': instance.page,
      'totalPage': instance.totalPages,
      'size': instance.size,
      'result': instance.items,
    };
