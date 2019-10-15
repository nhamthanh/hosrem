import 'package:hosrem_app/api/notification/notification.dart';
import 'package:meta/meta.dart';

/// Notifications state.
@immutable
abstract class NotificationsState {
}

/// NotificationsInitial state.
class NotificationsInitial extends NotificationsState {
  @override
  String toString() => 'NotificationsInitial';
}

/// NotificationsLoading state.
class NotificationsLoading extends NotificationsState {
  @override
  String toString() => 'NotificationsLoading';
}

/// NotificationsFailure state.
class NotificationsFailure extends NotificationsState {
  NotificationsFailure({@required this.error});

  final String error;

  @override
  String toString() => 'NotificationsFailure { error: $error }';
}

/// LoadedNotifications state.
class LoadedNotifications extends NotificationsState {
  LoadedNotifications({@required this.notifications}) :
      assert(notifications != null);

  final List<Notification> notifications;

  @override
  String toString() => 'LoadedNotifications';
}

/// RefreshNotificationsCompleted state.
@immutable
class RefreshNotificationsCompleted extends NotificationsState {
  RefreshNotificationsCompleted({@required this.notifications}) :
      assert(notifications != null);

  final List<Notification> notifications;

  @override
  String toString() => 'RefreshNotificationsCompleted';
}
