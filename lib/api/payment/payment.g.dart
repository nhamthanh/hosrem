// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) {
  return Payment(
    json['id'] as String,
    json['detail'] as String,
    json['payFor'] as String,
    json['payRef'] as String,
    json['paymentTypeId'] as String,
    json['status'] as String,
  );
}

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'detail': instance.detail,
      'payFor': instance.payFor,
      'payRef': instance.payRef,
      'paymentTypeId': instance.paymentTypeId,
      'status': instance.status,
    };
