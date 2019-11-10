import 'package:equatable/equatable.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:meta/meta.dart';

/// Profile state.
@immutable
abstract class ProfileState extends Equatable {
  const ProfileState([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// ProfileInitial state.
class ProfileInitial extends ProfileState {
  @override
  String toString() => 'ProfileInitial';
}

/// ProfileLoading state.
class ProfileLoading extends ProfileState {
  @override
  String toString() => 'ProfileLoading';
}

/// ProfileFailure state.
class ProfileFailure extends ProfileState {
  ProfileFailure({@required this.error}) : super(<String>[error]);

  final String error;

  @override
  String toString() => 'ProfileFailure { error: $error }';
}

/// ProfileSuccess state.
class ProfileSuccess extends ProfileState {
  ProfileSuccess({@required this.user}) : super(<User>[user]);

  final User user;
  @override
  String toString() => 'ProfileSuccess';
}
