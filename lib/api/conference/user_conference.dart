import 'package:json_annotation/json_annotation.dart';

import 'conference.dart';

part 'user_conference.g.dart';

/// User conference response model.
@JsonSerializable(nullable: false)
class UserConference {
  UserConference(this.conference);

  factory UserConference.fromJson(Map<String, dynamic> json) => _$UserConferenceFromJson(json);

  @JsonKey(name: 'conference')
  final Conference conference;

  Map<String, dynamic> toJson() => _$UserConferenceToJson(this);
}
