import 'package:hosrem_app/api/auth/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conference_registration.g.dart';

/// Conference response model.
@JsonSerializable(nullable: false)
class ConferenceRegistration {
  ConferenceRegistration(this.registrationId, this.conferenceId, this.fee, this.letterAddress, this.letterType, this.paymentStatus,
    this.paymentTypeId, this.registerTime, this.registrationType, this.userId, this.user);

  factory ConferenceRegistration.fromJson(Map<String, dynamic> json) => _$ConferenceRegistrationFromJson(json);

  @JsonKey(name: 'registrationId')
  final String registrationId;

  @JsonKey(name: 'conferenceId')
  final String conferenceId;

  @JsonKey(name: 'fee', nullable: true, defaultValue: 0.0)
  final double fee;

  @JsonKey(name: 'letterAddress')
  final String letterAddress;

  @JsonKey(name: 'letterType')
  final String letterType;

  @JsonKey(name: 'paymentStatus')
  final String paymentStatus;

  @JsonKey(name: 'paymentTypeId')
  final String paymentTypeId;

  @JsonKey(name: 'registerTime', nullable: true)
  final DateTime registerTime;

  @JsonKey(name: 'registrationType', nullable: true)
  final String registrationType;

  @JsonKey(name: 'userId')
  final String userId;

  @JsonKey(name: 'user', nullable: true)
  final User user;

  Map<String, dynamic> toJson() => _$ConferenceRegistrationToJson(this);
}
