// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) {
  return Notification(
    json['id'] as String,
    json['title'] as String,
    json['type'] as String,
    DateTime.parse(json['startTime'] as String),
  );
}

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.message,
      'startTime': instance.createdTime.toIso8601String(),
      'type': instance.type,
    };
