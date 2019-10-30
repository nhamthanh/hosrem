// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conference_registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConferenceRegistration _$ConferenceRegistrationFromJson(
    Map<String, dynamic> json) {
  return ConferenceRegistration(
    json['registrationId'] as String,
    json['conferenceId'] as String,
    (json['fee'] as num).toDouble(),
    json['letterAddress'] as String,
    json['letterType'] as String,
    json['paymentStatus'] as String,
    json['paymentTypeId'] as String,
    DateTime.parse(json['registerTime'] as String),
    json['registrationType'] as String,
    json['userId'] as String,
  );
}

Map<String, dynamic> _$ConferenceRegistrationToJson(
        ConferenceRegistration instance) =>
    <String, dynamic>{
      'registrationId': instance.registrationId,
      'conferenceId': instance.conferenceId,
      'fee': instance.fee,
      'letterAddress': instance.letterAddress,
      'letterType': instance.letterType,
      'paymentStatus': instance.paymentStatus,
      'paymentTypeId': instance.paymentTypeId,
      'registerTime': instance.registerTime.toIso8601String(),
      'registrationType': instance.registrationType,
      'userId': instance.userId,
    };
