import 'package:json_annotation/json_annotation.dart';

part 'api_error.g.dart';

/// Api error response model.
@JsonSerializable(nullable: false)
class ApiError {
  ApiError({this.status, this.error, this.message, this.timestamp, this.path});

  factory ApiError.fromJson(Map<String, dynamic> json) => _$ApiErrorFromJson(json);

  final int status;
  final String error;
  final String message;
  final String timestamp;
  final String path;

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);
}

