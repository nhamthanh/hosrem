import 'package:json_annotation/json_annotation.dart';

part 'conference_auth.g.dart';

/// Conference auth response model.
@JsonSerializable(nullable: false)
class ConferenceAuth {
  ConferenceAuth(this.id, this.fullName, this.regCode);

  factory ConferenceAuth.fromJson(Map<String, dynamic> json) => _$ConferenceAuthFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'fullName')
  final String fullName;

  @JsonKey(name: 'regCode')
  final String regCode;

  Map<String, dynamic> toJson() => _$ConferenceAuthToJson(this);

}
