// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conference_member_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConferenceMemberPagination _$ConferenceMemberPaginationFromJson(
    Map<String, dynamic> json) {
  return ConferenceMemberPagination(
    json['totalSize'] as int,
    json['page'] as int,
    json['totalPage'] as int,
    json['size'] as int,
    (json['result'] as List)
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ConferenceMemberPaginationToJson(
        ConferenceMemberPagination instance) =>
    <String, dynamic>{
      'totalSize': instance.totalItems,
      'page': instance.page,
      'totalPage': instance.totalPages,
      'size': instance.size,
      'result': instance.items,
    };
