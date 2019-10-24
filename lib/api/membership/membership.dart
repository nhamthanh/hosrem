import 'package:json_annotation/json_annotation.dart';

part 'membership.g.dart';

/// Conference response model.
@JsonSerializable(nullable: false)
class Membership {
  Membership(this.id, this.unit, this.duration, this.fee);

  factory Membership.fromJson(Map<String, dynamic> json) => _$MembershipFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'unit')
  final String unit;

  @JsonKey(name: 'duration')
  final int duration;

  @JsonKey(name: 'fee')
  final double fee;

  Map<String, dynamic> toJson() => _$MembershipToJson(this);
}
