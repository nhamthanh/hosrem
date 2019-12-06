// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conference_auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConferenceAuth _$ConferenceAuthFromJson(Map<String, dynamic> json) {
  return ConferenceAuth(
    json['id'] as String,
    json['fullName'] as String,
    json['regCode'] as String,
  );
}

Map<String, dynamic> _$ConferenceAuthToJson(ConferenceAuth instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'regCode': instance.regCode,
    };
