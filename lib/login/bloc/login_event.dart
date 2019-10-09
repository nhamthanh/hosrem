import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

/// Login event.
@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent([List<String> props = const <String>[]]) : super(props);
}

/// LoginButtonPressed event.
class LoginButtonPressed extends LoginEvent {
  LoginButtonPressed({
    @required this.email,
    @required this.password,
  }) : super(<String>[email, password]);

  final String email;
  final String password;

  @override
  String toString() =>
      'LoginButtonPressed { email: $email }';
}

/// LoginFacebookButtonPressed event.
class LoginFacebookButtonPressed extends LoginEvent {
  @override
  String toString() => 'LoginFacebookButtonPressed { }';
}
