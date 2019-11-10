import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'notification_pagination.dart';
import 'notification_token.dart';

part 'notification_api.g.dart';

/// Notification Api.
@RestApi()
abstract class NotificationApi {
  factory NotificationApi(Dio dio) = _NotificationApi;

  /// Get all notifications.
  @GET('conferences')
  Future<NotificationPagination> getAll(@Queries() Map<String, dynamic> query);

  /// Register a token.
  @POST('notifications/register')
  Future<NotificationToken> registerToken(@Body() NotificationToken notificationToken);
}

