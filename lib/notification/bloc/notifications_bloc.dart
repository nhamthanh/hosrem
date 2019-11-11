import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/api/notification/notification.dart' as alert;
import 'package:hosrem_app/api/notification/notification_pagination.dart';
import 'package:hosrem_app/common/error_handler.dart';

import '../notification_service.dart';
import 'notifications_event.dart';
import 'notifications_state.dart';

/// Notifications bloc to load documents by conference Id.
class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc({@required this.notificationService}) : assert(notificationService != null);

  static const int DEFAULT_PAGE = 0;
  static const int DEFAULT_PAGE_SIZE = 10;

  final NotificationService notificationService;

  List<alert.Notification> notifications = <alert.Notification>[];
  NotificationPagination notificationPagination;

  @override
  NotificationsState get initialState => NotificationsLoading();

  @override
  Stream<NotificationsState> mapEventToState(NotificationsEvent event) async* {
    if (event is RefreshNotificationsEvent) {
      try {
        notificationPagination = await notificationService.getNotifications(DEFAULT_PAGE, DEFAULT_PAGE_SIZE);
        notifications = notificationPagination.items;

        yield RefreshNotificationsCompleted(notifications: notifications);
        yield LoadedNotifications(notifications: notifications);
      } catch (error) {
        print(error);
        yield NotificationsFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is LoadMoreNotificationsEvent) {
      try {
        if (notificationPagination.page < notificationPagination.totalPages) {
          notificationPagination = await notificationService.getNotifications(notificationPagination.page + 1, DEFAULT_PAGE_SIZE);
          notifications.addAll(notificationPagination.items);
        }
        yield LoadedNotifications(notifications: notifications);
      } catch (error) {
        print(error);
        yield NotificationsFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is MarkAsReadEvent) {
      try {
        await notificationService.markNotificationAsRead(event.notificationId);
        notifications = notifications.map(
            (alert.Notification notification) => notification.id == event.notificationId
              ? notification.copyWith(unread: false)
              : notification).toList();
        yield LoadedNotifications(notifications: notifications);
      } catch (error) {
        print(error);
        yield NotificationsFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is MarkAllAsReadEvent) {
      try {
        await notificationService.markAllNotificationAsRead();
        notifications = notifications.map(
            (alert.Notification notification) => notification.copyWith(unread: false)).toList();
        yield LoadedNotifications(notifications: notifications);
      } catch (error) {
        print(error);
        yield NotificationsFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }
}
