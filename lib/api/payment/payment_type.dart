import 'package:json_annotation/json_annotation.dart';

part 'payment_type.g.dart';

/// Conference response model.
@JsonSerializable(nullable: false)
class PaymentType {
  PaymentType(this.id, this.type);

  factory PaymentType.fromJson(Map<String, dynamic> json) => _$PaymentTypeFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'type')
  final String type;

  Map<String, dynamic> toJson() => _$PaymentTypeToJson(this);
}
