// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationPagination _$NotificationPaginationFromJson(
    Map<String, dynamic> json) {
  return NotificationPagination(
    json['totalSize'] as int,
    json['page'] as int,
    json['totalPage'] as int,
    json['size'] as int,
    (json['result'] as List)
        .map((e) => Notification.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$NotificationPaginationToJson(
        NotificationPagination instance) =>
    <String, dynamic>{
      'totalSize': instance.totalItems,
      'page': instance.page,
      'totalPage': instance.totalPages,
      'size': instance.size,
      'result': instance.items,
    };
