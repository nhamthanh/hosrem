// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Membership _$MembershipFromJson(Map<String, dynamic> json) {
  return Membership(
    json['id'] as String,
    json['unit'] as String,
    json['duration'] as int,
    (json['fee'] as num).toDouble(),
  );
}

Map<String, dynamic> _$MembershipToJson(Membership instance) =>
    <String, dynamic>{
      'id': instance.id,
      'unit': instance.unit,
      'duration': instance.duration,
      'fee': instance.fee,
    };
