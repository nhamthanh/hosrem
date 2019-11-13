import 'package:dio/dio.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/auth/user_password.dart';
import 'package:hosrem_app/api/conference/user_conference.dart';
import 'package:hosrem_app/api/conference/user_conference_pagination.dart';
import 'package:hosrem_app/api/notification/notification_pagination.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api.g.dart';

/// User Api.
@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio) = _UserApi;

  /// Get user profile.
  @GET('users/{id}')
  Future<User> getUser(@Path() String id);

  /// Update user profile.
  @PUT('users/{id}')
  Future<User> updateUser(@Path() String id, @Body() User user);

    /// Update user password.
  @PUT('security/passwords/{id}')
  Future<bool> updateUserPassword(@Path() String id, @Body() UserPassword userPassword);

  /// Get conferences which user registered to join.
  @GET('users/{id}/registrations')
  Future<UserConferencePagination> getRegisteredConferences(@Path() String id, @Queries() Map<String, dynamic> query);

  /// Get specific conference which user registered to join.
  @GET('users/{userId}/registrations/{conferenceId}')
  Future<UserConference> getSpecificRegisteredConference(@Path() String userId, @Path() String conferenceId);

  /// Get user notifications.
  @GET('users/{id}/notifications')
  Future<NotificationPagination> getUserNotifications(@Path() String id, @Queries() Map<String, dynamic> query);

  /// Mark notification as read.
  @PUT('users/{id}/notifications/{notificationId}/read')
  Future<void> markAsRead(@Path() String id, @Path() String notificationId);

  /// Mark all notification as read.
  @PUT('users/{id}/notifications/read-all')
  Future<void> markAllAsRead(@Path() String id);
}

