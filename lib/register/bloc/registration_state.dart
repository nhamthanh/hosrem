import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

/// Registration state.
@immutable
abstract class RegistrationState extends Equatable {
  const RegistrationState([List<String> props = const <String>[]]) : super(props);
}

/// RegistrationInitial state.
class RegistrationInitial extends RegistrationState {
  @override
  String toString() => 'RegisterInitial';
}

/// RegistrationLoading state.
class RegistrationLoading extends RegistrationState {
  @override
  String toString() => 'RegistrationLoading';
}

/// RegistrationSuccess state.
class RegistrationSuccess extends RegistrationState {
  @override
  String toString() => 'RegistrationSuccess';
}

/// RegistrationFailure state.
class RegistrationFailure extends RegistrationState {
  RegistrationFailure({@required this.error}) : super(<String>[error]);

  final String error;

  @override
  String toString() => 'RegistrationFailure { error: $error }';
}
