import 'package:hosrem_app/api/auth/user.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

/// Register event.
@immutable
abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent([List<String> props = const <String>[]]) : super(props);
}

/// RegisterButtonPressed event.
class RegisterButtonPressed extends RegistrationEvent {
  RegisterButtonPressed({
    @required this.fullName,
    @required this.email,
    @required this.phone,
    @required this.password,
  }) : super(<String>[fullName, email, phone, password]);

  final String fullName;
  final String email;
  final String phone;
  final String password;

  User toUser() => User(null, 'Member', null, null, null, null, null, null, null, phone, null,
      email, fullName, null, null, 'Register', password, null);

  @override
  String toString() =>
      'RegisterButtonPressed { fullName: $fullName, phone: $phone, email: $email }';
}
