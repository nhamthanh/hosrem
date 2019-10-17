// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conference_fees.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConferenceFees _$ConferenceFeesFromJson(Map<String, dynamic> json) {
  return ConferenceFees(
    json['id'] as String,
    (json['memberFees'] as List)
        .map((e) => ConferenceFee.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['otherFees'] as List)
        .map((e) => ConferenceFee.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ConferenceFeesToJson(ConferenceFees instance) =>
    <String, dynamic>{
      'id': instance.id,
      'memberFees': instance.memberFees,
      'otherFees': instance.otherFees,
    };
