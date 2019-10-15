import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hosrem_app/api/auth/api_error.dart';
import 'package:hosrem_app/api/auth/auth_api.dart';
import 'package:hosrem_app/api/auth/token.dart';
import 'package:hosrem_app/api/auth/user_api.dart';
import 'package:hosrem_app/api/conference/conference_api.dart';
import 'package:hosrem_app/api/document/document_api.dart';
import 'package:hosrem_app/api/notification/notification_api.dart';
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
  DocumentApi _documentApi;
  NotificationApi _notificationApi;

  DefaultCacheManager _cacheManager;
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
        if (error.request.headers != null && !error.request.headers.containsKey('Retry')) {
          final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          final String email = sharedPreferences.get('email');
          final String password = sharedPreferences.get('password');
          if (email != null) {
            final Token token = await authApi.login(<String, String>{
              'username': email,
              'password': password
            });

            await sharedPreferences.setString('token', token.token);
            error.request.headers['Retry'] = true;
            return await dio.request<dynamic>(
              error.request.path,
              data: error.request.data,
              queryParameters: error.request.queryParameters,
              options: RequestOptions(
                method: error.request.method,
                headers: error.request.headers
              )
            );
          }
        }

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

  /// Get document api.
  DocumentApi get documentApi {
    _documentApi ??= DocumentApi(dio);
    return _documentApi;
  }

  /// Get cache manager.
  DefaultCacheManager get cacheManager {
    _cacheManager ??= DefaultCacheManager();
    return _cacheManager;
  }

  /// Get notification api.
  NotificationApi get notificationApi {
    _notificationApi ??= NotificationApi(dio);
    return _notificationApi;
  }
}
