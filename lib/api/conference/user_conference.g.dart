// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_conference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserConference _$UserConferenceFromJson(Map<String, dynamic> json) {
  return UserConference(
    json['conference'] == null
        ? null
        : Conference.fromJson(json['conference'] as Map<String, dynamic>),
    json['registrationCode'] as String,
  );
}

Map<String, dynamic> _$UserConferenceToJson(UserConference instance) =>
    <String, dynamic>{
      'conference': instance.conference,
      'registrationCode': instance.registrationCode,
    };
