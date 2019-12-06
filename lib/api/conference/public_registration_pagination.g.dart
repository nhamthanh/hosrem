// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_registration_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicRegistrationPagination _$PublicRegistrationPaginationFromJson(
    Map<String, dynamic> json) {
  return PublicRegistrationPagination(
    json['totalSize'] as int,
    json['page'] as int,
    json['totalPage'] as int,
    json['size'] as int,
    (json['result'] as List)
        .map((e) => PublicRegistration.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PublicRegistrationPaginationToJson(
        PublicRegistrationPagination instance) =>
    <String, dynamic>{
      'totalSize': instance.totalItems,
      'page': instance.page,
      'totalPage': instance.totalPages,
      'size': instance.size,
      'result': instance.items,
    };
