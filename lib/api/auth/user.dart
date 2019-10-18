import 'package:json_annotation/json_annotation.dart';

import 'degree.dart';
import 'field.dart';

part 'user.g.dart';

/// User response model.
@JsonSerializable(nullable: false)
class User {
  User(this.id, this.userType, this.firstName, this.lastName, this.dob, this.sex, this.company, this.department,
      this.address, this.phone, this.fax, this.email, this.fullName, this.degrees, this.fields, this.status,
      this.password, this.position);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'userType')
  final String userType;

  @JsonKey(name: 'firstName')
  final String firstName;

  @JsonKey(name: 'lastName')
  final String lastName;

  @JsonKey(name: 'dob', nullable: true)
  final DateTime dob;

  @JsonKey(name: 'sex')
  final String sex;

  @JsonKey(name: 'company')
  final String company;

  @JsonKey(name: 'department')
  final String department;

  @JsonKey(name: 'address')
  final String address;

  @JsonKey(name: 'phone')
  final String phone;

  @JsonKey(name: 'fax')
  final String fax;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'fullName')
  final String fullName;

  @JsonKey(name: 'degrees', nullable: true)
  final List<Degree> degrees;

  @JsonKey(name: 'fields', nullable: true)
  final List<Field> fields;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'password')
  final String password;

  @JsonKey(name: 'position')
  final String position;

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String id,
    String userType,
    String firstName,
    String lastName,
    String dob,
    String sex,
    String company,
    String department,
    String address,
    String phone,
    String fax,
    String email,
    String fullName,
    List<Degree> degrees,
    List<Field> fields,
    String status,
    String password,
    String position
  }) {
    return User(
      id ?? this.id,
      userType ?? this.userType,
      firstName ?? this.firstName,
      lastName ?? this.lastName,
      dob ?? this.dob,
      sex ?? this.sex,
      company ?? this.company,
      department ?? this.department,
      address ?? this.address,
      phone ?? this.phone,
      fax ?? this.fax,
      email ?? this.email,
      fullName ?? this.fullName,
      degrees ?? this.degrees,
      fields ?? this.fields,
      status ?? this.status,
      password ?? this.password,
      position ?? this.position
    );
  }
}
