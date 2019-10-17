// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as String,
    json['firstName'] as String,
    json['lastName'] as String,
    json['fullName'] as String,
    json['email'] as String,
    json['password'] as String,
    json['status'] as String,
    json['userType'] as String,
    json['position'] as String,
    json['company'] as String,
    json['avatar_url'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'fullName': instance.fullName,
      'email': instance.email,
      'password': instance.password,
      'status': instance.status,
      'userType': instance.userType,
      'position': instance.jobTitle,
      'company': instance.workingPlace,
      'avatar_url': instance.avatarUrl,
    };
