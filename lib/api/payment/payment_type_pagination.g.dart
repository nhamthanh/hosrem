// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_type_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentTypePagination _$PaymentTypePaginationFromJson(
    Map<String, dynamic> json) {
  return PaymentTypePagination(
    json['totalSize'] as int,
    json['page'] as int,
    json['totalPage'] as int,
    json['size'] as int,
    (json['result'] as List)
        .map((e) => PaymentType.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PaymentTypePaginationToJson(
        PaymentTypePagination instance) =>
    <String, dynamic>{
      'totalSize': instance.totalItems,
      'page': instance.page,
      'totalPage': instance.totalPages,
      'size': instance.size,
      'result': instance.items,
    };
