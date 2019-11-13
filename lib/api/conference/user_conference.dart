import 'package:json_annotation/json_annotation.dart';

import 'conference.dart';

part 'user_conference.g.dart';

/// User conference response model.
@JsonSerializable(nullable: false)
class UserConference {
  UserConference(this.conference, this.registrationCode);

  factory UserConference.fromJson(Map<String, dynamic> json) => _$UserConferenceFromJson(json);

  @JsonKey(name: 'conference', nullable: true)
  final Conference conference;

  @JsonKey(name: 'registrationCode', nullable: true)
  final String registrationCode;

  Map<String, dynamic> toJson() => _$UserConferenceToJson(this);
}
