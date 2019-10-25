import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Membership payment event.
@immutable
abstract class MembershipPaymentEvent extends Equatable {
  const MembershipPaymentEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// MomoPaymentEvent event.
class MomoPaymentEvent extends MembershipPaymentEvent {
  MomoPaymentEvent({@required this.token}) : super(<String>[token]);

  final String token;

  @override
  String toString() => 'MomoPaymentEvent { }';
}
