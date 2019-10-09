import 'api_error.dart';

/// Api exception.
class ApiException implements Exception {
  ApiException({this.message, this.statusCode, this.globalError, this.title, this.detail});

  /// Create [ApiException] from [json] object.
  ApiException.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        statusCode = json['status'],
        message = json['message'],
        detail = json['detail'],
        globalError = json['globalError'] != null ? ApiError.fromJson(json['globalError']) : null;

  final String title;
  final int statusCode;
  final String message;
  final String detail;
  final ApiError globalError;
}
