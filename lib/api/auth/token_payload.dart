import 'package:json_annotation/json_annotation.dart';

part 'token_payload.g.dart';

/// Token payload response model.
@JsonSerializable(nullable: false)
class TokenPayload {
  TokenPayload({this.id});

  factory TokenPayload.fromJson(Map<String, dynamic> json) => _$TokenPayloadFromJson(json);

  final String id;

  Map<String, dynamic> toJson() => _$TokenPayloadToJson(this);
}

