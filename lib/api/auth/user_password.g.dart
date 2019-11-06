// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPassword _$UserPasswordFromJson(Map<String, dynamic> json) {
  return UserPassword(
    json['message'] as String,
    json['newPassword'] as String,
    json['oldPassword'] as String,
  );
}

Map<String, dynamic> _$UserPasswordToJson(UserPassword instance) =>
    <String, dynamic>{
      'message': instance.message,
      'newPassword': instance.newPassword,
      'oldPassword': instance.oldPassword,
    };
