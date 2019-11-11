// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPassword _$ForgotPasswordFromJson(Map<String, dynamic> json) {
  return ForgotPassword(
    json['email'] as String,
    json['phone'] as String,
    json['userId'] as String,
  );
}

Map<String, dynamic> _$ForgotPasswordToJson(ForgotPassword instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'userId': instance.userId,
    };
