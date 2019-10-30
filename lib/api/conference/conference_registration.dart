import 'package:json_annotation/json_annotation.dart';

part 'conference_registration.g.dart';

/// Conference response model.
@JsonSerializable(nullable: false)
class ConferenceRegistration {
  ConferenceRegistration(this.registrationId, this.conferenceId, this.fee, this.letterAddress, this.letterType, this.paymentStatus,
    this.paymentTypeId, this.registerTime, this.registrationType, this.userId);

  factory ConferenceRegistration.fromJson(Map<String, dynamic> json) => _$ConferenceRegistrationFromJson(json);

  @JsonKey(name: 'registrationId')
  final String registrationId;

  @JsonKey(name: 'conferenceId')
  final String conferenceId;

  @JsonKey(name: 'fee')
  final double fee;

  @JsonKey(name: 'letterAddress')
  final String letterAddress;

  @JsonKey(name: 'letterType')
  final String letterType;

  @JsonKey(name: 'paymentStatus')
  final String paymentStatus;

  @JsonKey(name: 'paymentTypeId')
  final String paymentTypeId;

  @JsonKey(name: 'registerTime')
  final DateTime registerTime;

  @JsonKey(name: 'registrationType')
  final String registrationType;

  @JsonKey(name: 'userId')
  final String userId;

  Map<String, dynamic> toJson() => _$ConferenceRegistrationToJson(this);
}
