import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/membership/user_membership.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

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
  ProfileSuccess({@required this.user, @required this.userMembership}) : super(<User>[user]);

  final User user;
  final UserMembership userMembership;
  @override
  String toString() => 'ProfileSuccess';
}
