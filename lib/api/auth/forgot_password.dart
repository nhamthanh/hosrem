import 'package:json_annotation/json_annotation.dart';

part 'forgot_password.g.dart';

/// Forgot password response model.
@JsonSerializable(nullable: false)
class ForgotPassword {
  ForgotPassword(this.email, this.phone, this.userId);

  factory ForgotPassword.fromJson(Map<String, dynamic> json) => _$ForgotPasswordFromJson(json);

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'phone')
  final String phone;

  @JsonKey(name: 'userId')
  final String userId;

  Map<String, dynamic> toJson() => _$ForgotPasswordToJson(this);
}
