import 'package:json_annotation/json_annotation.dart';

part 'conference_fee.g.dart';

/// Conference fee response model.
@JsonSerializable(nullable: false)
class ConferenceFee {
  ConferenceFee(this.id, this.letterType, this.fee, this.onlineRegistration,
    this.milestone, this.registrationType, this.description);

  factory ConferenceFee.fromJson(Map<String, dynamic> json) => _$ConferenceFeeFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'letterType')
  final String letterType;

  @JsonKey(name: 'fee')
  final double fee;

  @JsonKey(name: 'onlineRegistration')
  final bool onlineRegistration;

  @JsonKey(name: 'milestone')
  final DateTime milestone;

  @JsonKey(name: 'registrationType')
  final String registrationType;

  @JsonKey(name: 'description')
  final String description;

  Map<String, dynamic> toJson() => _$ConferenceFeeToJson(this);
}
