import 'package:json_annotation/json_annotation.dart';

part 'update_registration_status.g.dart';

/// Conference response model.
@JsonSerializable(nullable: false)
class UpdateRegistrationStatus {
  UpdateRegistrationStatus(this.conferenceId, this.fullName, this.registrationCode, this.source, this.status, this.token, this.userId);

  factory UpdateRegistrationStatus.fromJson(Map<String, dynamic> json) => _$UpdateRegistrationStatusFromJson(json);

  @JsonKey(name: 'conferenceId')
  final String conferenceId;

  @JsonKey(name: 'fullName')
  final String fullName;

  @JsonKey(name: 'registrationCode')
  final String registrationCode;

  @JsonKey(name: 'source')
  final String source;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'token')
  final String token;

  @JsonKey(name: 'userId')
  final String userId;

  Map<String, dynamic> toJson() => _$UpdateRegistrationStatusToJson(this);
}
