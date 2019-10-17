// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conference_fee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConferenceFee _$ConferenceFeeFromJson(Map<String, dynamic> json) {
  return ConferenceFee(
    json['id'] as String,
    json['letterType'] as String,
    (json['fee'] as num).toDouble(),
    json['onlineRegistration'] as bool,
    DateTime.parse(json['milestone'] as String),
    json['registrationType'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$ConferenceFeeToJson(ConferenceFee instance) =>
    <String, dynamic>{
      'id': instance.id,
      'letterType': instance.letterType,
      'fee': instance.fee,
      'onlineRegistration': instance.onlineRegistration,
      'milestone': instance.milestone.toIso8601String(),
      'registrationType': instance.registrationType,
      'description': instance.description,
    };
