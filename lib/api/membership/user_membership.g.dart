// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_membership.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMembership _$UserMembershipFromJson(Map<String, dynamic> json) {
  return UserMembership(
    json['id'] as String,
    json['createdTime'] == null
        ? null
        : DateTime.parse(json['createdTime'] as String),
    json['expiredTime'] == null
        ? null
        : DateTime.parse(json['expiredTime'] as String),
    Membership.fromJson(json['membership'] as Map<String, dynamic>),
    json['paymentStatus'] as String,
    PaymentType.fromJson(json['paymentType'] as Map<String, dynamic>),
    json['registerTime'] == null
        ? null
        : DateTime.parse(json['registerTime'] as String),
    json['status'] as String,
    json['userId'] as String,
  );
}

Map<String, dynamic> _$UserMembershipToJson(UserMembership instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdTime': instance.createdTime?.toIso8601String(),
      'expiredTime': instance.expiredTime?.toIso8601String(),
      'membership': instance.membership,
      'paymentStatus': instance.paymentStatus,
      'paymentType': instance.paymentType,
      'registerTime': instance.registerTime?.toIso8601String(),
      'status': instance.status,
      'userId': instance.userId,
    };
