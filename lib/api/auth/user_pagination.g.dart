// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPagination _$UserPaginationFromJson(Map<String, dynamic> json) {
  return UserPagination(
    json['totalSize'] as int,
    json['page'] as int,
    json['totalPage'] as int,
    json['size'] as int,
    (json['result'] as List)
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UserPaginationToJson(UserPagination instance) =>
    <String, dynamic>{
      'totalSize': instance.totalItems,
      'page': instance.page,
      'totalPage': instance.totalPages,
      'size': instance.size,
      'result': instance.items,
    };
