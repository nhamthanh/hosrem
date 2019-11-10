// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationToken _$NotificationTokenFromJson(Map<String, dynamic> json) {
  return NotificationToken(
    json['token'] as String,
    json['userAgent'] as String,
    json['userId'] as String,
  );
}

Map<String, dynamic> _$NotificationTokenToJson(NotificationToken instance) =>
    <String, dynamic>{
      'token': instance.token,
      'userAgent': instance.userAgent,
      'userId': instance.userId,
    };
