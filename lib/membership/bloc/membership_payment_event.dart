import 'package:equatable/equatable.dart';
import 'package:hosrem_app/api/membership/membership.dart';
import 'package:hosrem_app/api/payment/payment_type.dart';
import 'package:meta/meta.dart';

/// Membership payment event.
@immutable
abstract class MembershipPaymentEvent extends Equatable {
  const MembershipPaymentEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// ProcessMomoPaymentEvent event.
class ProcessMomoPaymentEvent extends MembershipPaymentEvent {
  ProcessMomoPaymentEvent({@required this.detail, @required this.membership, @required this.paymentType}) :
      super(<dynamic>[detail, membership, paymentType]);

  final Map<String, dynamic> detail;
  final Membership membership;
  final PaymentType paymentType;

  @override
  String toString() => 'ProcessMomoPaymentEvent { }';
}

/// LoadPaymentDataEvent event.
class LoadPaymentDataEvent extends MembershipPaymentEvent {
  @override
  String toString() => 'LoadPaymentDataEvent { }';
}

/// ChangePaymentMethodEvent event.
class ChangePaymentMethodEvent extends MembershipPaymentEvent {
  ChangePaymentMethodEvent({@required this.paymentTypes, @required this.selectedPayment}) :
      super(<dynamic>[paymentTypes, selectedPayment]);

  final List<PaymentType> paymentTypes;
  final String selectedPayment;

  @override
  String toString() => 'ChangePaymentMethodEvent { }';
}


