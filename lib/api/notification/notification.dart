import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

/// Notification response model.
@JsonSerializable(nullable: false)
class Notification {
  Notification(this.id, this.message, this.type, this.createdTime);

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'title')
  final String message;

  @JsonKey(name: 'startTime')
  final DateTime createdTime;

  @JsonKey(name: 'type')
  final String type;

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}
