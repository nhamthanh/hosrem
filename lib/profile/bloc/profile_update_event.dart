import 'package:equatable/equatable.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:meta/meta.dart';

/// Login event.
@immutable
abstract class ProfileUpdateEvent extends Equatable {
  const ProfileUpdateEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// LoadProfileEvent event.
class LoadProfileEvent extends ProfileUpdateEvent {
  @override
  String toString() =>
      'LoadProfileEvent { }';
}

/// SaveProfileEvent event.
class SaveProfileEvent extends ProfileUpdateEvent {
  SaveProfileEvent(this.user) : super(<User>[user]);

  final User user;

  @override
  String toString() => 'SaveProfileEvent { }';
}

/// LoadProfileEvent event.
class ChangeProfileEvent extends ProfileUpdateEvent {
  ChangeProfileEvent(this.user) : super(<User>[user]);

  final User user;

  @override
  String toString() =>
      'LoadProfileEvent { }';
}
