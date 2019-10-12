// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) {
  return ApiError(
    status: json['status'] as int,
    error: json['error'] as String,
    message: json['message'] as String,
    timestamp: json['timestamp'] as String,
    path: json['path'] as String,
  );
}

Map<String, dynamic> _$ApiErrorToJson(ApiError instance) => <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
      'timestamp': instance.timestamp,
      'path': instance.path,
    };
