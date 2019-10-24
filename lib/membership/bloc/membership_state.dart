import 'package:equatable/equatable.dart';
import 'package:hosrem_app/api/membership/membership.dart';
import 'package:meta/meta.dart';

/// Membership state.
@immutable
abstract class MembershipState extends Equatable {
  const MembershipState([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// MembershipInitial state.
class MembershipInitial extends MembershipState {
  @override
  String toString() => 'MembershipInitial';
}

/// MembershipLoading state.
class MembershipLoading extends MembershipState {
  @override
  String toString() => 'MembershipLoading';
}

/// MembershipFailure state.
class MembershipFailure extends MembershipState {
  MembershipFailure({@required this.error}) : super(<String>[error]);

  final String error;

  @override
  String toString() => 'MembershipFailure { error: $error }';
}

/// MembershipSuccess state.
class MembershipSuccess extends MembershipState {
  MembershipSuccess({@required this.memberships, this.selectedMembership}) :
      super(<dynamic>[memberships, selectedMembership]);

  final List<Membership> memberships;
  final Membership selectedMembership;

  @override
  String toString() => 'MembershipSuccess';
}
