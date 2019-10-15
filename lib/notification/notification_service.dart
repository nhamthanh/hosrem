import 'package:hosrem_app/api/notification/notification_pagination.dart';
import 'package:hosrem_app/network/api_provider.dart';

/// Notification service.
class NotificationService {
  NotificationService(this.apiProvider) : assert(apiProvider != null);

  final ApiProvider apiProvider;

  /// Get notifications.
  Future<NotificationPagination> getNotifications(int page, int size) async {
    final NotificationPagination notificationPagination = await apiProvider.notificationApi.getAll(<String, dynamic>{
      'page': page,
      'size': size
    });
    return notificationPagination;
  }
}
