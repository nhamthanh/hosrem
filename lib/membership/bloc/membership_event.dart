import 'package:equatable/equatable.dart';
import 'package:hosrem_app/api/membership/membership.dart';
import 'package:meta/meta.dart';

/// Membership event.
@immutable
abstract class MembershipEvent extends Equatable {
  const MembershipEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// LoadMembershipEvent event.
class LoadMembershipEvent extends MembershipEvent {
  @override
  String toString() => 'LoadMembershipEvent { }';
}


/// SelectMembershipEvent event.
class SelectMembershipEvent extends MembershipEvent {
  SelectMembershipEvent({@required this.selectedMembership, @required this.memberships}) :
      super(<dynamic>[memberships, selectedMembership]);

  final Membership selectedMembership;
  final List<Membership> memberships;

  @override
  String toString() => 'SelectMembershipEvent { }';
}
