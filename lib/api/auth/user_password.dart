import 'package:json_annotation/json_annotation.dart';
part 'user_password.g.dart';

/// UserPassword response model.
@JsonSerializable(nullable: false)
class UserPassword {
  UserPassword(this.message, this.newPassword, this.oldPassword, this.userId, this.validationCode);

  factory UserPassword.fromJson(Map<String, dynamic> json) => _$UserPasswordFromJson(json);

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'newPassword')
  final String newPassword;

  @JsonKey(name: 'oldPassword')
  final String oldPassword;

  @JsonKey(name: 'userId')
  final String userId;

  @JsonKey(name: 'validationCode')
  final String validationCode;

  UserPassword copyWith({
    String message,
    String newPassword,
    String oldPassword,
    String userId,
    String validationCode,
  }) {
    return UserPassword(
      message ?? this.message,
      newPassword ?? this.newPassword,
      oldPassword ?? this.oldPassword,
      userId ?? this.userId,
      validationCode ?? this.validationCode,
    );
  }

  Map<String, dynamic> toJson() => _$UserPasswordToJson(this);
}
