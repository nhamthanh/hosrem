import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

/// Login state.
@immutable
abstract class LoginState extends Equatable {
  const LoginState([List<String> props = const <String>[]]) : super(props);
}

/// LoginInitial state.
class LoginInitial extends LoginState {
  @override
  String toString() => 'LoginInitial';
}

/// LoginLoading state.
class LoginLoading extends LoginState {
  @override
  String toString() => 'LoginLoading';
}

/// LoginFailure state.
class LoginFailure extends LoginState {
  LoginFailure({@required this.error}) : super(<String>[error]);

  final String error;

  @override
  String toString() => 'LoginFailure { error: $error }';
}

/// LoginSuccess state.
class LoginSuccess extends LoginState {
  @override
  String toString() => 'LoginSuccess';
}
