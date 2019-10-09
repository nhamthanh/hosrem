import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

/// Token response model.
@JsonSerializable(nullable: false)
class Token {
  Token({this.token});

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  final String token;

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}

