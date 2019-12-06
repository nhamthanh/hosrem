// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicRegistration _$PublicRegistrationFromJson(Map<String, dynamic> json) {
  return PublicRegistration(
    json['company'] as String,
    json['fullName'] as String,
    json['membershipStatus'] as String,
    json['registrationPaymentStatus'] as String,
    json['registrationStatus'] as String,
    json['userStatus'] as String,
  );
}

Map<String, dynamic> _$PublicRegistrationToJson(PublicRegistration instance) =>
    <String, dynamic>{
      'company': instance.company,
      'fullName': instance.fullName,
      'membershipStatus': instance.membershipStatus,
      'registrationPaymentStatus': instance.registrationPaymentStatus,
      'registrationStatus': instance.registrationStatus,
      'userStatus': instance.userStatus,
    };
