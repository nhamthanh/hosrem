import 'package:meta/meta.dart';

/// Home state.
@immutable
abstract class HomeState {
  const HomeState(this.itemIndex, this.title);

  final String title;
  final int itemIndex;
}

/// ShowNews state.
@immutable
class ShowNews extends HomeState {
  const ShowNews() : super(0, 'News');

  @override
  String toString() => 'ShowNews';
}

/// ShowEvents state.
@immutable
class ShowEvents extends HomeState {
  const ShowEvents() : super(1, 'Events');

  @override
  String toString() => 'ShowEvents';
}

/// ShowNotifications state.
@immutable
class ShowNotifications extends HomeState {
  const ShowNotifications({ this.hasToken = false }) : super(2, 'Notifications');

  final bool hasToken;

  @override
  String toString() => 'ShowNotifications';
}

/// ShowProfile state.
@immutable
class ShowProfile extends HomeState {
  const ShowProfile() : super(3, 'Profile');

  @override
  String toString() => 'ShowProfile';
}
