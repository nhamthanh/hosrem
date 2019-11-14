import 'package:equatable/equatable.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:meta/meta.dart';

/// Register event.
@immutable
abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// RegisterButtonPressed event.
class RegisterButtonPressed extends RegistrationEvent {
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
class CleanRegistrationEvent extends RegistrationEvent {
  @override
  String toString() => 'CleanRegistrationEvent {}';
}
