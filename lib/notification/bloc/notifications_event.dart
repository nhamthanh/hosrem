import 'package:meta/meta.dart';

/// Notifications event.
@immutable
abstract class NotificationsEvent {
}

/// LoadMoreNotificationsEvent event.
class LoadMoreNotificationsEvent extends NotificationsEvent {
  @override
  String toString() => 'LoadMoreNotificationsEvent { }';
}

/// RefreshNotificationsEvent event.
class RefreshNotificationsEvent extends NotificationsEvent {
  @override
  String toString() => 'RefreshNotificationsEvent { }';
}

/// MarkAsReadEvent event.
class MarkAsReadEvent extends NotificationsEvent {
  MarkAsReadEvent(this.notificationId);

  final String notificationId;

  @override
  String toString() => 'MarkAsReadEvent { }';
}

/// MarkAllAsReadEvent event.
class MarkAllAsReadEvent extends NotificationsEvent {
  @override
  String toString() => 'MarkAllAsReadEvent { }';
}
