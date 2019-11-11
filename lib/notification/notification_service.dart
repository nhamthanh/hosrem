import 'package:flutter_user_agent/flutter_user_agent.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/notification/notification_pagination.dart';
import 'package:hosrem_app/api/notification/notification_token.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/network/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Notification service.
class NotificationService {
  NotificationService(this.apiProvider) : assert(apiProvider != null);

  final ApiProvider apiProvider;

  /// Get notifications.
  Future<NotificationPagination> getNotifications(int page, int size) async {
    final AuthService authService = AuthService(apiProvider);
    final User user = await authService.currentUser();
    final NotificationPagination notificationPagination =
      await apiProvider.userApi.getUserNotifications(user.id, <String, dynamic>{
        'page': page,
        'size': size,
        'sort': 'createdTime:desc'
      });
    return notificationPagination;
  }

  /// Register notification token.
  Future<void> registerToken(String token) async {
    final String userAgent = await FlutterUserAgent.getPropertyAsync('userAgent');
    final AuthService authService = AuthService(apiProvider);
    final User user = await authService.currentUser();
    await apiProvider.notificationApi.registerToken(NotificationToken(token, userAgent, user?.id));
  }

  /// Persist FCM token [token] into shared preferences.
  Future<void> persistFcmToken(String token) async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setString('fcmToken', token);
  }

  /// Get FCM token from shared preferences.
  Future<String> getFcmToken() async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.get('fcmToken');
  }

  /// Mark notification as read.
  Future<void> markNotificationAsRead(String notificationId) async {
    final AuthService authService = AuthService(apiProvider);
    final User user = await authService.currentUser();
    return apiProvider.userApi.markAsRead(user.id, notificationId);
  }

  /// Mark notification as read.
  Future<void> markAllNotificationAsRead() async {
    final AuthService authService = AuthService(apiProvider);
    final User user = await authService.currentUser();
    return apiProvider.userApi.markAllAsRead(user.id);
  }
}
