import 'package:hosrem_app/api/auth/user.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

/// Auth event.
@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// LoginButtonPressed event.
class LoginButtonPressed extends AuthEvent {
  LoginButtonPressed({
    @required this.email,
    @required this.password,
  }) : super(<String>[email, password]);

  final String email;
  final String password;

  @override
  String toString() => 'LoginButtonPressed { email/phone: $email }';
}

/// RegisterButtonPressed event.
class RegisterButtonPressed extends AuthEvent {
  RegisterButtonPressed({
    @required this.fullName,
    @required this.email,
    @required this.phone,
    @required this.password,
    @required this.checked
  }) : super(<dynamic>[fullName, email, phone, password, checked]);

  final String fullName;
  final String email;
  final String phone;
  final String password;
  final bool checked;

  User toUser() => User(null, 'Member', null, null, null, null, null, null, null, phone, null,
    email, fullName, null, null, 'UnConfirmed', password, null, null, null, null);

  @override
  String toString() =>
    'RegisterButtonPressed { fullName: $fullName, phone: $phone, email: $email }';
}

/// CleanRegistrationEvent event.
class CleanRegistrationEvent extends AuthEvent {
  @override
  String toString() => 'CleanRegistrationEvent {}';
}

/// LoginFacebookButtonPressed event.
class LoginFacebookButtonPressed extends AuthEvent {
  @override
  String toString() => 'LoginFacebookButtonPressed { }';
}
