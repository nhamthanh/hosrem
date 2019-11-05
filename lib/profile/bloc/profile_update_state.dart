import 'package:hosrem_app/api/auth/degree.dart';
import 'package:hosrem_app/api/auth/field.dart' as field;
import 'package:hosrem_app/api/auth/user.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

/// Profile state.
@immutable
abstract class ProfileUpdateState extends Equatable {
  const ProfileUpdateState([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// ProfileInitial state.
class ProfileInitial extends ProfileUpdateState {
  @override
  String toString() => 'ProfileInitial';
}

/// ProfileLoading state.
class ProfileLoading extends ProfileUpdateState {
  @override
  String toString() => 'ProfileLoading';
}

/// ProfileFailure state.
class ProfileFailure extends ProfileUpdateState {
  ProfileFailure({@required this.error}) : super(<String>[error]);

  final String error;

  @override
  String toString() => 'ProfileFailure { error: $error }';
}

/// ProfileDataUpdate state.
class ProfileDataUpdate extends ProfileUpdateState {
  ProfileDataUpdate({@required this.user, this.degrees, this.fields, this.index}) : super(<User>[user]);

  final User user;
  final List<Degree> degrees;
  final List<field.Field> fields;
  final int index;
  @override
  String toString() => 'ProfileDataUpdate';
}

/// UpdateProfileSuccess state.
class UpdateProfileSuccess extends ProfileUpdateState {
  @override
  String toString() => 'UpdateProfileSuccess';
}