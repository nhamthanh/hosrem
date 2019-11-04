// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_conference_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserConferencePagination _$UserConferencePaginationFromJson(
    Map<String, dynamic> json) {
  return UserConferencePagination(
    json['totalSize'] as int,
    json['page'] as int,
    json['totalPage'] as int,
    json['size'] as int,
    (json['result'] as List)
        .map((e) => UserConference.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UserConferencePaginationToJson(
        UserConferencePagination instance) =>
    <String, dynamic>{
      'totalSize': instance.totalItems,
      'page': instance.page,
      'totalPage': instance.totalPages,
      'size': instance.size,
      'result': instance.items,
    };
