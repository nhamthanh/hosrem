// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as String,
    json['userType'] as String,
    json['firstName'] as String,
    json['lastName'] as String,
    json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
    json['sex'] as String,
    json['company'] as String,
    json['department'] as String,
    json['address'] as String,
    json['phone'] as String,
    json['fax'] as String,
    json['email'] as String,
    json['fullName'] as String,
    (json['degrees'] as List)
        ?.map((e) =>
            e == null ? null : Degree.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['fields'] as List)
        ?.map(
            (e) => e == null ? null : Field.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['status'] as String,
    json['password'] as String,
    json['position'] as String,
    json['expiredTime'] == null
        ? null
        : DateTime.parse(json['expiredTime'] as String),
    json['membershipStatus'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'userType': instance.userType,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'dob': instance.dob?.toIso8601String(),
      'sex': instance.sex,
      'company': instance.company,
      'department': instance.department,
      'address': instance.address,
      'phone': instance.phone,
      'fax': instance.fax,
      'email': instance.email,
      'fullName': instance.fullName,
      'degrees': instance.degrees,
      'fields': instance.fields,
      'status': instance.status,
      'password': instance.password,
      'position': instance.position,
      'expiredTime': instance.expiredTime?.toIso8601String(),
      'membershipStatus': instance.membershipStatus,
    };
