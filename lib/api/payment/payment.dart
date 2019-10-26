import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

/// Conference response model.
@JsonSerializable(nullable: false)
class Payment {
  Payment(this.id, this.detail, this.payFor, this.payRef, this.paymentTypeId, this.status);

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'detail')
  final Map<String, dynamic> detail;

  @JsonKey(name: 'payFor')
  final String payFor;

  @JsonKey(name: 'payRef')
  final String payRef;

  @JsonKey(name: 'paymentTypeId')
  final String paymentTypeId;

  @JsonKey(name: 'status')
  final String status;

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
