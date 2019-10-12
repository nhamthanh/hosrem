// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conference_resource_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConferenceResourcePagination _$ConferenceResourcePaginationFromJson(
    Map<String, dynamic> json) {
  return ConferenceResourcePagination(
    json['totalSize'] as int,
    json['page'] as int,
    json['totalPage'] as int,
    json['size'] as int,
    (json['result'] as List)
        .map((e) => ConferenceResource.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ConferenceResourcePaginationToJson(
        ConferenceResourcePagination instance) =>
    <String, dynamic>{
      'totalSize': instance.totalItems,
      'page': instance.page,
      'totalPage': instance.totalPages,
      'size': instance.size,
      'result': instance.items,
    };
