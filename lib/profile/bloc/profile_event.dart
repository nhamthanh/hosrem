import 'package:equatable/equatable.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:meta/meta.dart';

/// Login event.
@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// LoadProfileEvent event.
class LoadProfileEvent extends ProfileEvent {
  @override
  String toString() =>
      'LoadProfileEvent { }';
}

/// SaveProfileEvent event.
class SaveProfileEvent extends ProfileEvent {
  SaveProfileEvent(this.user) : super(<User>[user]);

  final User user;

  @override
  String toString() => 'SaveProfileEvent { }';
}

/// ReloadProfileEvent event.
class ReloadProfileEvent extends ProfileEvent {
  @override
  String toString() => 'ReloadProfileEvent { }';
}
