// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MembershipPagination _$MembershipPaginationFromJson(Map<String, dynamic> json) {
  return MembershipPagination(
    json['totalSize'] as int,
    json['page'] as int,
    json['totalPage'] as int,
    json['size'] as int,
    (json['result'] as List)
        .map((e) => Membership.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MembershipPaginationToJson(
        MembershipPagination instance) =>
    <String, dynamic>{
      'totalSize': instance.totalItems,
      'page': instance.page,
      'totalPage': instance.totalPages,
      'size': instance.size,
      'result': instance.items,
    };
