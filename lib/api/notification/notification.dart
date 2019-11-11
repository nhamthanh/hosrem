import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

/// Notification response model.
@JsonSerializable(nullable: false)
class Notification {
  Notification(this.id, this.title, this.message, this.unread, this.notificationType, this.createdTime, this.payload);

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

  @JsonKey(name: 'payload')
  final Map<String, dynamic> payload;

  Notification copyWith({
    String id,
    String title,
    String message,
    bool unread,
    DateTime createdTime,
    String notificationType,
    Map<String, dynamic> payload
  }) {
    return Notification(
      id ?? this.id,
      title ?? this.title,
      message ?? this.message,
      unread ?? this.unread,
      notificationType ?? this.notificationType,
      createdTime ?? this.createdTime,
      payload ?? this.payload
    );
  }

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}
