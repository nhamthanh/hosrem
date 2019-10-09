import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// User response model.
@JsonSerializable(nullable: false)
class User {
  User(this.firstName, this.lastName, this.fullName, this.email, this.password, this.status,
    this.userType, this.jobTitle, this.workingPlace, this.avatarUrl);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @JsonKey(name: 'firstName')
  final String firstName;

  @JsonKey(name: 'lastName')
  final String lastName;

  @JsonKey(name: 'fullName')
  final String fullName;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'password')
  final String password;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'userType')
  final String userType;

  @JsonKey(name: 'position')
  final String jobTitle;

  @JsonKey(name: 'company')
  final String workingPlace;

  @JsonKey(name: 'avatar_url')
  final String avatarUrl;

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String firstName,
    String lastName,
    String fullName,
    String email,
    String password,
    String status,
    String userType,
    String jobTitle,
    String workingPlace,
    String avatarUrl
  }) {
    return User(
      firstName ?? this.firstName,
      lastName ?? this.lastName,
      fullName ?? this.fullName,
      email ?? this.email,
      password ?? this.password,
      status ?? this.status,
      userType ?? this.userType,
      jobTitle ?? this.jobTitle,
      workingPlace ?? this.workingPlace,
      avatarUrl ?? this.avatarUrl
    );
  }
}
