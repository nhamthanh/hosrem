import 'package:json_annotation/json_annotation.dart';
part 'user_password.g.dart';

/// UserPassword response model.
@JsonSerializable(nullable: false)
class UserPassword {
  UserPassword(this.message, this.newPassword, this.oldPassword);

  factory UserPassword.fromJson(Map<String, dynamic> json) => _$UserPasswordFromJson(json);

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'newPassword')
  final String newPassword;

  @JsonKey(name: 'oldPassword')
  final String oldPassword;

  UserPassword copyWith({
    String message,
    String newPassword,
    String oldPassword,
  }) {
    return UserPassword(
      message ?? this.message,
      newPassword ?? this.newPassword,
      oldPassword ?? this.oldPassword,
    );
  }

  Map<String, dynamic> toJson() => _$UserPasswordToJson(this);
}
