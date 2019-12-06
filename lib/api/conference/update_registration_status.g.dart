// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_registration_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateRegistrationStatus _$UpdateRegistrationStatusFromJson(
    Map<String, dynamic> json) {
  return UpdateRegistrationStatus(
    json['conferenceId'] as String,
    json['fullName'] as String,
    json['registrationCode'] as String,
    json['source'] as String,
    json['status'] as String,
    json['token'] as String,
    json['userId'] as String,
  );
}

Map<String, dynamic> _$UpdateRegistrationStatusToJson(
        UpdateRegistrationStatus instance) =>
    <String, dynamic>{
      'conferenceId': instance.conferenceId,
      'fullName': instance.fullName,
      'registrationCode': instance.registrationCode,
      'source': instance.source,
      'status': instance.status,
      'token': instance.token,
      'userId': instance.userId,
    };
