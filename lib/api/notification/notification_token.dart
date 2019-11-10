import 'package:json_annotation/json_annotation.dart';

part 'notification_token.g.dart';

/// Notification token.
@JsonSerializable(nullable: false)
class NotificationToken {
  NotificationToken(this.token, this.userAgent, this.userId);

  factory NotificationToken.fromJson(Map<String, dynamic> json) => _$NotificationTokenFromJson(json);

  @JsonKey(name: 'token')
  final String token;

  @JsonKey(name: 'userAgent')
  final String userAgent;

  @JsonKey(name: 'userId')
  final String userId;

  Map<String, dynamic> toJson() => _$NotificationTokenToJson(this);
}
