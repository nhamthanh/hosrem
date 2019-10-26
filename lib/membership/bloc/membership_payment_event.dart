import 'package:equatable/equatable.dart';
import 'package:hosrem_app/api/membership/membership.dart';
import 'package:hosrem_app/api/payment/payment_type.dart';
import 'package:meta/meta.dart';

/// Membership payment event.
@immutable
abstract class MembershipPaymentEvent extends Equatable {
  const MembershipPaymentEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// MomoPaymentEvent event.
class MomoPaymentEvent extends MembershipPaymentEvent {
  MomoPaymentEvent({@required this.detail, @required this.membership, @required this.paymentType}) :
      super(<dynamic>[detail, membership, paymentType]);

  final Map<String, dynamic> detail;
  final Membership membership;
  final PaymentType paymentType;

  @override
  String toString() => 'MomoPaymentEvent { }';
}

/// LoadPaymentDataEvent event.
class LoadPaymentDataEvent extends MembershipPaymentEvent {
  @override
  String toString() => 'LoadPaymentDataEvent { }';
}


