import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hosrem_app/api/auth/auth_api.dart';
import 'package:hosrem_app/api/auth/user_api.dart';
import 'package:hosrem_app/api/conference/conference_api.dart';
import 'package:hosrem_app/api/document/document_api.dart';
import 'package:hosrem_app/api/membership/membership_api.dart';
import 'package:hosrem_app/api/membership/user_membership_api.dart';
import 'package:hosrem_app/api/notification/notification_api.dart';
import 'package:hosrem_app/api/payment/payment_api.dart';
import 'package:hosrem_app/api/payment/payment_type_api.dart';

import 'auth_interceptor.dart';

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
  MembershipApi _membershipApi;
  UserMembershipApi _userMembershipApi;
  PaymentApi _paymentApi;
  PaymentTypeApi _paymentTypeApi;
  DefaultCacheManager _cacheManager;
  Function() _onUnauthorized;

  void _initDio(String baseUrl) {
    final BaseOptions dioOptions = BaseOptions()..baseUrl = baseUrl;

    dio = Dio(dioOptions);
    dio.interceptors
      ..add(LogInterceptor(requestBody: true, responseBody: true))
      ..add(AuthInterceptor(this, () => _onUnauthorized));
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

  /// Get membership api.
  MembershipApi get membershipApi {
    _membershipApi ??= MembershipApi(dio);
    return _membershipApi;
  }

  /// Get user membership api.
  UserMembershipApi get userMembershipApi {
    _userMembershipApi ??= UserMembershipApi(dio);
    return _userMembershipApi;
  }

  /// Get payment api.
  PaymentApi get paymentApi {
    _paymentApi ??= PaymentApi(dio);
    return _paymentApi;
  }

  /// Get payment type api.
  PaymentTypeApi get paymentTypeApi {
    _paymentTypeApi ??= PaymentTypeApi(dio);
    return _paymentTypeApi;
  }
}
