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
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.password,
    @required this.jobTitle,
    @required this.workingPlace
  }) : super(<String>[firstName, lastName, email, password, jobTitle, workingPlace]);

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String jobTitle;
  final String workingPlace;

  User toUser() => User(null, firstName, lastName, '$firstName $lastName', email, password, 'Register', 'Member',
    jobTitle, workingPlace, null);

  @override
  String toString() =>
      'RegisterButtonPressed { firstName: $firstName, lastName: $lastName, email: $email }';
}
