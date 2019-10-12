import 'package:dio/dio.dart';
import 'package:hosrem_app/api/auth/api_error.dart';
import 'package:hosrem_app/api/auth/auth_api.dart';
import 'package:hosrem_app/api/auth/user_api.dart';
import 'package:hosrem_app/api/conference/conference_api.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Api provider.
class ApiProvider {
  ApiProvider(String baseUrl) {
    _initDio(baseUrl);
  }

  Dio dio;

  AuthApi _authApi;
  ConferenceApi _conferenceApi;
  UserApi _userApi;
  Logger _logger;

  Function() _onUnauthorized;

  void _initDio(String baseUrl) {
    _logger = Logger('ApiProvider');
    final BaseOptions dioOptions = BaseOptions()..baseUrl = baseUrl;

    dio = Dio(dioOptions);
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      options.headers['Context-Type'] = 'application/json';
      final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
      final String token = _sharedPreferences.getString('token');
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer ' + token;
      }
      return options;
    }, onResponse: (Response<dynamic> response) {
      return response;
    }, onError: (DioError error) async {
      _logger.fine(error.message);
      if (error.response?.statusCode == 401 && error.request.path != 'login') {
        final AuthService authService = AuthService(this);
        await authService.clearUser();
        _onUnauthorized();
      }
      error.response.extra['apiError'] = _parseApiError(error);
      return error;
    }));
  }

  ApiError _parseApiError(DioError error) {
    ApiError apiError = ApiError(message: 'Failed to process data from backend');
    try {
      apiError = ApiError.fromJson(error.response?.data);
    } catch (error) {
      _logger.fine(error.message);
    }
    return apiError;
  }

  /// Register [onUnauthorized] event to receive error if backend responds 401.
  void registerUnauthorizedEvent(Function() onUnauthorized) {
    _onUnauthorized = onUnauthorized;
  }

  /// Get auth api.
  AuthApi get authApi {
    _authApi ??= AuthApi(dio);
    return _authApi;
  }

  /// Get user api.
  UserApi get userApi {
    _userApi ??= UserApi(dio);
    return _userApi;
  }

  /// Get conference api.
  ConferenceApi get conferenceApi {
    _conferenceApi ??= ConferenceApi(dio);
    return _conferenceApi;
  }
}
