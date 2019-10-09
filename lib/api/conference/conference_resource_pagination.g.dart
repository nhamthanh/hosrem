// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conference_resource_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConferenceResourcePagination _$ConferenceResourcePaginationFromJson(
    Map<String, dynamic> json) {
  return ConferenceResourcePagination(
    json['total_items'] as int,
    json['page'] as int,
    json['total_pages'] as int,
    json['size'] as int,
    (json['items'] as List)
        .map((e) => ConferenceResource.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ConferenceResourcePaginationToJson(
        ConferenceResourcePagination instance) =>
    <String, dynamic>{
      'total_items': instance.totalItems,
      'page': instance.page,
      'total_pages': instance.totalPages,
      'size': instance.size,
      'items': instance.items,
    };
