import 'package:dio/dio.dart';
import 'package:hosrem_app/api/auth/api_error.dart';
import 'package:logging/logging.dart';

/// Error handler to handle message from api services.
class ErrorHandler {
  ErrorHandler._();

  static final Logger _logger = Logger('ErrorHandler');

  /// Extract display error message from [exception].
  static String extractErrorMessage(dynamic exception) {
    if (exception is DioError) {
      try {
        // ignore: avoid_as
        final ApiError apiError = exception.response?.extra['apiError'] as ApiError;
        return apiError.message;
      } catch (error) {
        _logger.fine(error.toString());
      }
    }
    return exception.toString();
  }
}

