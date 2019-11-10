import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

/// Notification response model.
@JsonSerializable(nullable: false)
class Notification {
  Notification(this.id, this.title, this.message, this.unread, this.notificationType, this.createdTime);

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'unread')
  final bool unread;

  @JsonKey(name: 'createdTime')
  final DateTime createdTime;

  @JsonKey(name: 'notificationType')
  final String notificationType;

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}
