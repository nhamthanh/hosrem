import 'package:json_annotation/json_annotation.dart';

import 'conference_fee.dart';

part 'conference_fees.g.dart';

/// Conference fees response model.
@JsonSerializable(nullable: false)
class ConferenceFees {
  ConferenceFees(this.id, this.memberFees, this.otherFees);

  factory ConferenceFees.fromJson(Map<String, dynamic> json) => _$ConferenceFeesFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'memberFees')
  final List<ConferenceFee> memberFees;

  @JsonKey(name: 'otherFees')
  final List<ConferenceFee> otherFees;

  Map<String, dynamic> toJson() => _$ConferenceFeesToJson(this);
}
