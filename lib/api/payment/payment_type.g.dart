// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentType _$PaymentTypeFromJson(Map<String, dynamic> json) {
  return PaymentType(
    json['id'] as String,
    json['type'] as String,
  );
}

Map<String, dynamic> _$PaymentTypeToJson(PaymentType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };
