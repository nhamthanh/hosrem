import 'package:hosrem_app/api/payment/payment_type.dart';
import 'package:json_annotation/json_annotation.dart';

import 'membership.dart';

part 'user_membership.g.dart';

/// Conference response model.
@JsonSerializable(nullable: false)
class UserMembership {
  UserMembership(this.id, this.createdTime, this.expiredTime, this.membership, this.paymentStatus, this.paymentType,
      this.registerTime, this.status, this.userId);

  factory UserMembership.fromJson(Map<String, dynamic> json) => _$UserMembershipFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'createdTime', nullable: true)
  final DateTime createdTime;

  @JsonKey(name: 'expiredTime', nullable: true)
  final DateTime expiredTime;

  @JsonKey(name: 'membership')
  final Membership membership;

  @JsonKey(name: 'paymentStatus', nullable: true)
  final String paymentStatus;

  @JsonKey(name: 'paymentType')
  final PaymentType paymentType;

  @JsonKey(name: 'registerTime', nullable: true)
  final DateTime registerTime;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'userId')
  final String userId;

  Map<String, dynamic> toJson() => _$UserMembershipToJson(this);
}
