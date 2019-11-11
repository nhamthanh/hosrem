// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) {
  return Notification(
    json['id'] as String,
    json['title'] as String,
    json['message'] as String,
    json['unread'] as bool,
    json['notificationType'] as String,
    DateTime.parse(json['createdTime'] as String),
    json['payload'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'unread': instance.unread,
      'createdTime': instance.createdTime.toIso8601String(),
      'notificationType': instance.notificationType,
      'payload': instance.payload,
    };
