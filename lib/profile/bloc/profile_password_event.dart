import 'package:equatable/equatable.dart';
import 'package:hosrem_app/api/auth/user_password.dart';
import 'package:meta/meta.dart';

/// Profile Password event.
@immutable
abstract class ProfilePasswordEvent extends Equatable {
  const ProfilePasswordEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// ChangePasswordButtonPressed event.
class ChangePasswordButtonPressed extends ProfilePasswordEvent {
  const ChangePasswordButtonPressed(this.id, this.userPassword);

  final String id;
  final UserPassword userPassword;
  @override
  String toString() =>
      'ChangePasswordButtonPressed {id: $id}';
}

/// CleanProfilePasswordEvent event.
class CleanProfilePasswordEvent extends ProfilePasswordEvent {
  @override
  String toString() => 'CleanProfilePasswordEvent {}';
}
