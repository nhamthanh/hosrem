import 'package:json_annotation/json_annotation.dart';

part 'public_registration.g.dart';

/// Public Registration response model.
@JsonSerializable(nullable: false)
class PublicRegistration {
  PublicRegistration(this.company, this.fullName, this.membershipStatus, this.registrationPaymentStatus, this.registrationStatus, this.userStatus);

  factory PublicRegistration.fromJson(Map<String, dynamic> json) => _$PublicRegistrationFromJson(json);

  @JsonKey(name: 'company')
  final String company;

  @JsonKey(name: 'fullName')
  final String fullName;

  @JsonKey(name: 'membershipStatus')
  final String membershipStatus;

  @JsonKey(name: 'registrationPaymentStatus')
  final String registrationPaymentStatus;

  @JsonKey(name: 'registrationStatus')
  final String registrationStatus;

  @JsonKey(name: 'userStatus')
  final String userStatus;

  Map<String, dynamic> toJson() => _$PublicRegistrationToJson(this);

}
