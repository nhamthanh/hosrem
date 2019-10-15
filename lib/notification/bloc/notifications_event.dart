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
